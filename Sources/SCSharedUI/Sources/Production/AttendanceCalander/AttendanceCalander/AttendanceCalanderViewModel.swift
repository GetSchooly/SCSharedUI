import Combine
import Foundation
import SCComponents
import SwiftUICore
import UIKit

class AttendanceCalanderViewModel: LoadableViewModel<AttendanceCalanderModel> {
    @Published var selectedMonth: SDPickerModel = .init(id: 1, year: 2025, title: "")
    private(set) var months: [SDPickerModel] = []
    private(set) var attendanceStatus: [AttendanceStatus] = []
    @Published private(set) var calendarData: [CalendarDayModel] = []
    @Published private(set) var studentAttendances: [StudentAttendance] = []
    private lazy var attendanceActivities: AttendanceCalanderService = .init()
    private var cancellables = Set<AnyCancellable>()
    @Published var isShareSheetPresented: Bool = false
    @Published var attendaceSheetImage: UIImage?

    override init() {
        super.init()
        studentAttendances = AttendanceCalanderModel.mockAttendance.studentAttendance
        setupCurrentMonthCalendarData()
        setAllMonths()
        attendanceStatus = AttendanceStatus.allCases
        selectedMonth = months.filter { $0.id == getCurrentMonth }.first ?? months[0]
        observeAttendance()
    }

    private func observeAttendance() {
        $loadingState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .loaded(let model):
                    self.studentAttendances = model.studentAttendance
                    self.setupCurrentMonthCalendarData()
                default:
                    break
                }
            }
            .store(in: &cancellables)
    }

    func fetchAttendance(studentId: Int) {
        let publisher = attendanceActivities.fetchStudentAttendance(
            studentId: studentId,
            month: selectedMonth.id,
            year: selectedMonth.year
        )
        load(publisher: publisher)
    }

    var currentAssessmentYear: String {
        let currentYear = Calendar.current.component(.year, from: Date())
        return "\(currentYear)/\(nextYear)"
    }

    func dateAppeareance(_ status: AttendanceStatus) -> CGFloat {
        if status == .upcoming {
            return 0.2
        } else if status == .sunday {
            return 0.5
        }
        return 1
    }
}

extension AttendanceCalanderViewModel {
    private var getCurrentMonth: Int {
        return Calendar.current.component(.month, from: Date())
    }

    private var currentYear: Int {
        return Calendar.current.component(.year, from: Date())
    }

    private var nextYear: Int {
        return Calendar.current.component(.year, from: Date()) + 1
    }

    private func setupCurrentMonthCalendarData() {
        calendarData.removeAll()

        let components = Calendar.current.dateComponents([.month, .year], from: Date())
        guard let month = components.month,
        let year = components.year else { return }
        getDaysWithMonth(month, year: year)
    }

    private func getDaysWithMonth(_ month: Int, year: Int) {
        guard let allDays = getAllDaysOfMonth(month, year: year) else { return }
        for date in 1...allDays {
            let weekdayName = getWeekdayName(date: date, month: month, year: year) ?? "-"
            calendarData.append(
                CalendarDayModel(
                    day: weekdayName,
                    date: String("\(date).\(month).\(year)"),
                    status: getAttendanceStatus(
                        weekdayName: weekdayName,
                        day: date,
                        month: month,
                        year: year
                    )
                )
            )
        }
    }

    private func getAttendanceStatus(
        weekdayName: String,
        day: Int,
        month: Int,
        year: Int
    ) -> AttendanceStatus {
        if weekdayName.lowercased() == "sunday" {
            return .sunday
        }

        let dateString = "\(year)-\(month)-\(day)"
        if let studentAttendance = studentAttendances.first(where: { model in
            model.markAttendance == normalizeDate(dateString)
        }) {
            return studentAttendance.isPresent
        }
        return .none
    }

    private func setAllMonths() {
        let allMonths = [
            "January - \(nextYear)",
            "February - \(nextYear)",
            "March - \(nextYear)",
            "April - \(nextYear)",
            "May - \(currentYear)",
            "June - \(currentYear)",
            "July - \(currentYear)",
            "August - \(currentYear)",
            "September - \(currentYear)",
            "October - \(currentYear)",
            "November - \(currentYear)",
            "December - \(currentYear)"
        ]
        allMonths.forEach { month in
            let index = allMonths.firstIndex(of: month) ?? 0
            months.append(
                SDPickerModel(
                    id: index + 1,
                    year: [1, 2, 3, 4].contains(index + 1) ? nextYear : currentYear,
                    title: month
                )
            )
        }
    }

    private func getWeekdayName(date: Int, month: Int, year: Int) -> String? {
        let calendar = Calendar.current

        var dateComponents = DateComponents()
        dateComponents.day = date
        dateComponents.month = month
        dateComponents.year = year

        guard let date = calendar.date(from: dateComponents) else { return nil }
        let weekdayNumber = calendar.component(.weekday, from: date)

        let formatter = DateFormatter()
        formatter.locale = Locale.current
        let weekdayName = formatter.weekdaySymbols[weekdayNumber - 1]
        return weekdayName
    }

    private func getAllDaysOfMonth(_ month: Int, year: Int) -> Int? {
        let calendar = Calendar.current
        let startDateComponents = DateComponents(year: year, month: month, day: 1)

        var endDateComponents = DateComponents()
        endDateComponents.day = 1
        endDateComponents.month = month == 12 ? 1 : month + 1
        endDateComponents.year = month == 12 ? year + 1 : year

        guard let startDate = calendar.date(from: startDateComponents), let endDate = calendar.date(from: endDateComponents) else { return nil}

        let diff = calendar.dateComponents([.day], from: startDate, to: endDate)
        return diff.day
    }

    private func normalizeDate(_ raw: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-M-d"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd"

        if let date = inputFormatter.date(from: raw) {
            return outputFormatter.string(from: date)
        }
        return nil
    }
}
