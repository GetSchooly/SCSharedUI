import Foundation
import Combine

enum FeeStatus: Codable {
    case paid
    case due
    case none
}

struct MyChildrenModel: Codable {
    let studentData: [StudentData]
}

public struct StudentData: Codable, Hashable {
    let id: Int
    let studentName: String
    let studentProfileImage: String?
    let feeStatus: FeeStatus?
    
    init(id: Int, studentName: String, studentProfileImage: String? = nil, feeStatus: FeeStatus = .none) {
        self.id = id
        self.studentName = studentName
        self.studentProfileImage = studentProfileImage
        self.feeStatus = feeStatus
    }
}

public extension StudentData {
    static func == (lhs: StudentData, rhs: StudentData) -> Bool {
        return lhs.id == rhs.id
    }
}

protocol MyChildrenServiceProtocol {
    func fetchAllRegisteredChildren() -> AnyPublisher<ResponseModel<MyChildrenModel>, Error>
    func fetchAllMarkedChildren() -> AnyPublisher<ResponseModel<MyChildrenModel>, Error>
    func linkChildToParent(_ childIds: [String]) -> AnyPublisher<ResponseModel<EmptyDataModel>, Error>
}

class MyChildrenViewService: MyChildrenServiceProtocol {
    let apiClient = URLSessionAPIClient<ParentHomeEndpoint>()

    func fetchAllRegisteredChildren() -> AnyPublisher<ResponseModel<MyChildrenModel>, Error> {
        return apiClient.request(.getAllRegisteredStudent)
    }

    func fetchAllMarkedChildren() -> AnyPublisher<ResponseModel<MyChildrenModel>, Error> {
        return apiClient.request(.getAllMarkStudent)
    }

    func linkChildToParent(_ childIds: [String]) -> AnyPublisher<ResponseModel<EmptyDataModel>, Error> {
        return apiClient.request(.linkStudentandParent)
    }
}

// MARK: - Mock
public extension StudentData {
    static let mockStudent: StudentData =  StudentData(
        id: 1,
        studentName: "Test Name",
        studentProfileImage: "https://picsum.photos/seed/picsum/200/300"
        )

    static let mockStudents: [StudentData] = [
        StudentData(
            id: 1,
            studentName: "Test Name",
            studentProfileImage: "https://picsum.photos/seed/picsum/200/300",
            feeStatus: .paid
            ),
        StudentData(
            id: 2,
            studentName: "Test Name",
            studentProfileImage: "https://picsum.photos/seed/picsum/200/300",
            feeStatus: .due
            ),
        StudentData(
            id: 3,
            studentName: "Test Name",
            studentProfileImage: "https://picsum.photos/seed/picsum/200/300",
            feeStatus: .paid
            )
    ]
}
