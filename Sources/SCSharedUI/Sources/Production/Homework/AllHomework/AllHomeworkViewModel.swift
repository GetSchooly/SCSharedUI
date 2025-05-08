import Foundation
import SCComponents

public class AllHomeworkViewModel: ObservableObject {
    
    let data: [AllHomeworkModel]
    let calendarViewModel: CalendarViewModel
    
    // MARK:- Initialize
    public init(data: [AllHomeworkModel]) {
        // Do something
        self.data = data
        self.calendarViewModel = CalendarViewModel()
    }
    
    // MARK: - Fetching functions
    func fetchData() {
        // Do something
    }
    
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
