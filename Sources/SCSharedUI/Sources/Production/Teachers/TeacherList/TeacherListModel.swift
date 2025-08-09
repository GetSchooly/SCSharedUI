import Foundation
import Combine

// MARK: - TeacherListModel
struct TeacherListModel: Codable {
    let studentTask: [TeacherProfile]
}

// MARK: - StudentTask
public struct TeacherProfile: Codable, Identifiable {
    public let id: Int
    public let teacherName, subjectName: String
    public let teacherProfileImage: String?
}

protocol TeacherListServiceProtocol {
    func getTeacherListBy(studentId: String) -> AnyPublisher<ResponseModel<TeacherListModel>, Error>
}

class TeacherListViewService: TeacherListServiceProtocol {
    let apiClient = URLSessionAPIClient()

    func getTeacherListBy(studentId: String) -> AnyPublisher<ResponseModel<TeacherListModel>, Error> {
        let endpoint = ParentApiEndPoint.getTeachersByStudent(studentId: studentId)
        return apiClient.request(endpoint)
    }
}

// MARK: - Mock
extension TeacherListModel {
    static let mockATeacher: TeacherProfile = .init(
        id: 1,
        teacherName: "Sumit Awasthi",
        subjectName: "Mathematic",
        teacherProfileImage: "https://picsum.photos/id/103/200/200"
    )

    static let mockTechers: TeacherListModel = .init(
        studentTask: [
            TeacherProfile(
                id: 1,
                teacherName: "Sumit Awasthi",
                subjectName: "Mathematic",
                teacherProfileImage: "https://picsum.photos/id/103/200/200"
            ),
            TeacherProfile(
                id: 2,
                teacherName: "Arpit Yadav",
                subjectName: "English",
                teacherProfileImage: "https://picsum.photos/id/103/200/200"
            ),
            TeacherProfile(
                id: 3,
                teacherName: "Mic Joe",
                subjectName: "English",
                teacherProfileImage: "https://picsum.photos/id/103/200/200"
            ),
            TeacherProfile(
                id: 4,
                teacherName: "Bryan Long",
                subjectName: "Arts",
                teacherProfileImage: "https://picsum.photos/id/103/200/200"
            ),
            TeacherProfile(
                id: 4,
                teacherName: "Sumit Awasthi",
                subjectName: "Science",
                teacherProfileImage: "https://picsum.photos/id/103/200/200"
            )
        ]
    )
}
