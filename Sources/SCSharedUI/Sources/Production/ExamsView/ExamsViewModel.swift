import Foundation

public class ExamsViewModel: ObservableObject {
    var examDetailList: [ExamsModel] = []
    
    public init() {
        // Do something
        
        examDetailList = [
            ExamsModel(subject: "English", id: 1, date: "01 April 2025", endTime: "03:30PM", startTime: "12:30PM", mark: "65", passingMark: "33"),
            ExamsModel(subject: "Hindi", id: 2, date: "02 April 2025", endTime: "03:30PM", startTime: "12:30PM", mark: "65", passingMark: "33"),
            ExamsModel(subject: "Maths", id: 3, date: "03 April 2025", endTime: "03:30PM", startTime: "12:30PM", mark: "65", passingMark: "33"),
            ExamsModel(subject: "Science", id: 4, date: "04 April 2025", endTime: "03:30PM", startTime: "12:30PM", mark: "65", passingMark: "33"),
            ExamsModel(subject: "History", id: 5, date: "05 April 2025", endTime: "03:30PM", startTime: "12:30PM", mark: "65", passingMark: "33"),
            ExamsModel(subject: "Social Science", id: 6, date: "06 April 2025", endTime: "03:30PM", startTime: "12:30PM", mark: "65", passingMark: "33")
        ]
    }
}
