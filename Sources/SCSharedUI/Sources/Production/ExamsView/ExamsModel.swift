import Foundation
import Combine

struct ExamsModel: Codable{
    let examList:[ExamDetails]
}

public struct ExamDetails:Codable, Identifiable, Hashable {
   public let id: Int?
    var exam_type: String?
    let date:String?
    let class_name:Int
    let schedules:[Schedules]?
    var isCompletedExam: Bool {
       return isOldDate(dateString: date ?? Date().toString)
    }

     func isOldDate(dateString: String) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let givenDate = formatter.date(from: dateString) else {
            return false // invalid date string
        }
        let currentDate = Date()
        return givenDate < currentDate
    }
}




 public struct Schedules:Codable, Identifiable, Hashable{
    public var id: Int
    let subject_name: String?
    let start_time: String?
    let end_time: String?
    let max_marks: Int?
    let obtainedMarks: Int?
}




protocol StudentExamServiceProtocol{
    func fetchStudentExamBy(studentId: String, action:String) -> AnyPublisher<ResponseModel<ExamsModel>, Error>
}

class StudentExamService: StudentExamServiceProtocol {
    let apiClient = URLSessionAPIClient()
    func fetchStudentExamBy(studentId: String,  action:String) -> AnyPublisher<ResponseModel<ExamsModel>, any Error> {
        
        let endPoint = StudentProfileEndPoint.getStudentExamList(studentId: studentId, action: action)
            return apiClient.request(endPoint)
    }
}

// MARK: - Mock
extension ExamsModel {
    static let moackDetail: ExamDetails = ExamDetails(id: 1, exam_type: "WEEKLY", date: "2025-08-17", class_name: 49, schedules: [Schedules(id: 1, subject_name: "Hindi", start_time: nil, end_time: nil, max_marks: 100, obtainedMarks: 25)])
    
    static let mockExams: ExamsModel = .init(
        examList:[
            .init(id: 2, exam_type: "WEEKLY", date: "2025-08-17", class_name: 49, schedules: [Schedules(id: 1, subject_name: "Hindi", start_time: nil, end_time: nil, max_marks: 100, obtainedMarks: 25)]),
            
                .init(id: 3, exam_type: "WEEKLY", date: "2025-08-17", class_name: 49, schedules: [Schedules(id: 1, subject_name: "Hindi", start_time: nil, end_time: nil, max_marks: 100, obtainedMarks: 25)]),
            
                .init(id: 4, exam_type: "WEEKLY", date: "2025-08-17", class_name: 49, schedules: [Schedules(id: 1, subject_name: "Hindi", start_time: nil, end_time: nil, max_marks: 100, obtainedMarks: 25)]),
            
            .init(id: 5, exam_type: "WEEKLY", date: "2025-08-17", class_name: 49, schedules: [Schedules(id: 1, subject_name: "Hindi", start_time: nil, end_time: nil, max_marks: 100, obtainedMarks: 25)]),
            
            .init(id: 6, exam_type: "WEEKLY", date: "2025-08-17", class_name: 49, schedules: [Schedules(id: 1, subject_name: "Hindi", start_time: nil, end_time: nil, max_marks: 100, obtainedMarks: 25)])
        ]
            
        
    )
}

extension Date {
    var toString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDateString = formatter.string(from: self)
        return currentDateString
    }
}
