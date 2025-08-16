import Foundation
import SCComponents
import Combine

class HomeworkViewModel: LoadableViewModel<HomeworkModel> {
    private lazy var studentTaskService: StudentTaskService = .init()
    private var cancellables: Set<AnyCancellable> = []
    @Published private(set) var homeworks: [StudentTask] = []
    lazy var calendarViewModel: CalendarViewModel = CalendarViewModel()
    @Published private(set) var completedHomeworks: [StudentTask] = []
    @Published private(set) var pendingHomeworks: [StudentTask] = []

    override init() {
        super.init()
        homeworks = StudentTask.mockTasks.studentTask
        setHomeworks()
        observeStudentHomeworks()
    }

    private func observeStudentHomeworks() {
        $loadingState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] loadingState in
                guard let self else { return }
                switch loadingState {
                case .loaded(let model):
                    homeworks = model.studentTask
                    self.setHomeworks()
                default: break
                }
            }
            .store(in: &cancellables)
    }

    private func setHomeworks() {
        completedHomeworks = homeworks.compactMap { $0.isTaskCompleted ? $0 : nil }
        pendingHomeworks = homeworks.compactMap { $0.isTaskCompleted == false ? $0 : nil }
    }

    func fetchStudentHomeworks(studentId: String, selectedDate: String) {
        let publisher = studentTaskService.fetchStudentTaskBy(studentId: studentId, selectedDate: selectedDate)
        load(publisher: publisher)
    }
}

extension HomeworkViewModel {
    func selectedDateMonthYear() -> String {
        let date = calendarViewModel.selectedDate.formatted(Date.FormatStyle().day(.twoDigits))
        let month = calendarViewModel.selectedDate.formatted(Date.FormatStyle().month(.wide))
        let year = calendarViewModel.selectedDate.formatted(Date.FormatStyle().year(.defaultDigits))
        return "\(month) \(date), \(year)"
    }

    func selectedDateFullDayName() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        let fullDayName = formatter.string(from: calendarViewModel.selectedDate)
        return fullDayName
    }
}
