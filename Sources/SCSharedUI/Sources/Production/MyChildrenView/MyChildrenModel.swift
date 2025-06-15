import Foundation
import Combine

class MyChildrenModel: Codable {
    var studentData: [StudentData]
}

public struct StudentData: Codable, Hashable {
    let id: Int
    let studentName: String
    let studentProfileImage: String?
    
    init(id: Int, studentName: String, studentProfileImage: String? = nil) {
        self.id = id
        self.studentName = studentName
        self.studentProfileImage = studentProfileImage
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
}

class MyChildrenViewService: MyChildrenServiceProtocol {
    let apiClient = URLSessionAPIClient<ParentHomeEndpoint>()
    
    func fetchAllRegisteredChildren() -> AnyPublisher<ResponseModel<MyChildrenModel>, Error> {
        return apiClient.request(.getAllRegisteredStudent)
    }
    
    func fetchAllMarkedChildren() -> AnyPublisher<ResponseModel<MyChildrenModel>, any Error> {
        return apiClient.request(.getAllMarkStudent)
    }
}

//MARK: - Mock
public extension StudentData {
    static let mockStudent: StudentData =  StudentData(
        id: 1,
        studentName: "Test Name",
        studentProfileImage: "https://picsum.photos/seed/picsum/200/300"
        )

    static let mockStudents: [StudentData] = [mockStudent, mockStudent, mockStudent]
}
