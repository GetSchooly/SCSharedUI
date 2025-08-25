import Foundation
import Combine

// MARK: - TeacherListModel
struct TeacherListModel: Codable {
    let studentTask: [TeacherProfile]
}

// MARK: - StudentTask
public struct TeacherProfile: Codable, Identifiable {
    public let id: Int
    public let isClassTeacher: Bool
    public let teacherName, subjectName: String
    public let teacherProfileImage, teacherMobileNo: String?
    public let teacherExperience: Int?
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
        isClassTeacher: true,
        teacherName: "Sumit Awasthi",
        subjectName: "Mathematic",
        teacherProfileImage: "https://picsum.photos/id/103/200/200",
        teacherMobileNo: "+911234567890",
        teacherExperience: 2
    )

    static let mockTechers: TeacherListModel = .init(
        studentTask: [
            TeacherProfile(
                id: 1,
                isClassTeacher: true,
                teacherName: "Sumit Awasthi",
                subjectName: "Mathematic",
                teacherProfileImage: "https://picsum.photos/id/103/200/200",
                teacherMobileNo: "+911234567890",
                teacherExperience: 2
            ),
            TeacherProfile(
                id: 2,
                isClassTeacher: false,
                teacherName: "Arpit Yadav",
                subjectName: "English",
                teacherProfileImage: "https://picsum.photos/id/103/200/200",
                teacherMobileNo: "+911234567890",
                teacherExperience: 2
            ),
            TeacherProfile(
                id: 3,
                isClassTeacher: false,
                teacherName: "Mic Joe",
                subjectName: "English",
                teacherProfileImage: "https://picsum.photos/id/103/200/200",
                teacherMobileNo: "+911234567890",
                teacherExperience: 2
            ),
            TeacherProfile(
                id: 4,
                isClassTeacher: false,
                teacherName: "Bryan Long",
                subjectName: "Arts",
                teacherProfileImage: "https://picsum.photos/id/103/200/200",
                teacherMobileNo: "+911234567890",
                teacherExperience: 2
            ),
            TeacherProfile(
                id: 5,
                isClassTeacher: false,
                teacherName: "Sumit Awasthi",
                subjectName: "Science",
                teacherProfileImage: "https://picsum.photos/id/103/200/200",
                teacherMobileNo: "+911234567890",
                teacherExperience: 2
            )
        ]
    )
}
