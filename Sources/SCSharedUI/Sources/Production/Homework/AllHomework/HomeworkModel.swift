import Foundation
import Combine

// MARK: - HomeworkModel
struct HomeworkModel: Codable {
    let studentTask: [StudentTask]
}

// MARK: - StudentTask
public struct StudentTask: Codable, Hashable, Identifiable {
    public let id: Int
    let teacherName, subjectName: String
    let isTaskCompleted: Bool
    let taskFile: String?
    let remarks, submissionDate, createdAt, updatedAt: String
    let assignclassNameID, uploadedTeacher, subjectID: Int

    enum CodingKeys: String, CodingKey {
        case id, teacherName, subjectName, isTaskCompleted
        case taskFile = "task_file"
        case remarks
        case submissionDate = "submission_date"
        case createdAt, updatedAt
        case assignclassNameID = "assignclassNameId"
        case uploadedTeacher
        case subjectID = "subjectId"
    }
}

protocol StudentTaskServiceProtocol {
    func fetchStudentTaskBy(studentId: String, selectedDate: String) -> AnyPublisher<ResponseModel<HomeworkModel>, Error>
}

class StudentTaskService: StudentTaskServiceProtocol {
    let apiClient = URLSessionAPIClient()

    func fetchStudentTaskBy(studentId: String, selectedDate: String) -> AnyPublisher<ResponseModel<HomeworkModel>, Error> {
        let endPoint = StudentProfileEndPoint.getStudentTaskList(studentId: studentId, selectedDate: selectedDate)
        return apiClient.request(endPoint)
    }
}

// MARK: - Mock
extension StudentTask {
    static let mockTasks: HomeworkModel = .init(
        studentTask: [
            .init(
                id: 1,
                teacherName: "Mukul Tiwari",
                subjectName: "English",
                isTaskCompleted: false,
                taskFile: nil,
                remarks: "Mukul Tiwari is a very good teacher",
                submissionDate: "2025-05-31",
                createdAt: "2025-05-31T04:21:10.793408Z",
                updatedAt: "2025-05-31T04:21:10.793408Z",
                assignclassNameID: 29,
                uploadedTeacher: 44,
                subjectID: 28
            ),
            .init(
                id: 2,
                teacherName: "Mukul Tiwari",
                subjectName: "Maths",
                isTaskCompleted: false,
                taskFile: nil,
                remarks: "Mukul Tiwari is a very good teacher",
                submissionDate: "2025-05-31",
                createdAt: "2025-05-31T04:21:10.793408Z",
                updatedAt: "2025-05-31T04:21:10.793408Z",
                assignclassNameID: 29,
                uploadedTeacher: 44,
                subjectID: 28
            ),
            .init(
                id: 3,
                teacherName: "Mukul Tiwari",
                subjectName: "English",
                isTaskCompleted: false,
                taskFile: nil,
                remarks: "Mukul Tiwari is a very good teacher",
                submissionDate: "2025-05-31",
                createdAt: "2025-05-31T04:21:10.793408Z",
                updatedAt: "2025-05-31T04:21:10.793408Z",
                assignclassNameID: 29,
                uploadedTeacher: 44,
                subjectID: 28
            ),
            .init(
                id: 4,
                teacherName: "Mukul Tiwari",
                subjectName: "English",
                isTaskCompleted: true,
                taskFile: nil,
                remarks: "Mukul Tiwari is a very good teacher",
                submissionDate: "2025-05-31",
                createdAt: "2025-05-31T04:21:10.793408Z",
                updatedAt: "2025-05-31T04:21:10.793408Z",
                assignclassNameID: 29,
                uploadedTeacher: 44,
                subjectID: 28
            )
        ]
    )
}
