import Foundation
import SCComponents
import SwiftUICore

public class AttendanceCalanderViewModel: ObservableObject {
    
    var currentAssessmentYear: String {
        return "2024/2025"
    }
    @Published var selectedMonth: SDPickerModel?
    private(set) var months: [SDPickerModel] = []
    private(set) var attendanceStatus: [AttendanceStatus] = []
    @Published private(set) var calendarData: [CalendarDayModel] = []
    
    // MARK:- Initialize
    public init() {
        // Do something
        setupAttendanceStatus()
        setupCurrentMonthCalendarData()
        setAllMonths()
        selectedMonth = months.filter { $0.id == getCurrentMonth }.first
    }
    
    // MARK: - Fetching functions
    func fetchData() {
        // Do something
    }
    
    private func setupAttendanceStatus() {
        attendanceStatus = AttendanceStatus.allCases
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
                CalendarDayModel(day: weekdayName,
                                 date: String("\(date)./\(month)./\(year)"),
                                 status: getAttendanceStatus(weekdayName))
            )
        }
    }
    
    private func getAttendanceStatus(_ day: String) -> AttendanceStatus {
        if day.lowercased() == "sunday" {
            return .none
        }
        return .present
    }
    
    private func setAllMonths() {
       let allMonths = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        allMonths.forEach { month in
            let index = allMonths.firstIndex(of: month) ?? 0
            months.append(SDPickerModel(id: index + 1, title: month))
        }
    }
    
    private var getCurrentMonth: Int {
        return Calendar.current.component(.month, from: Date())
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
}
