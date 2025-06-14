import Foundation
import RealmSwift
import Combine

class MyChildrenModel: Codable {
    var studentData: [StudentData]
}

class StudentData: Object, Codable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var studentName: String
    @Persisted var studentProfileImage: String?
}

protocol MyChildrenServiceProtocol {
    func fetchAllRegisteredChildren() -> AnyPublisher<ResponseModel<MyChildrenModel>, Error>
    //func getAllMarkedChildren() -> AnyPublisher<ResponseModel<[StudentData]>, Error>
}

class MyChildrenViewService: MyChildrenServiceProtocol {
    let apiClient = URLSessionAPIClient<ParentHomeEndpoint>()
    
    func fetchAllRegisteredChildren() -> AnyPublisher<ResponseModel<MyChildrenModel>, Error> {
        return apiClient.request(.getAllRegisteredStudent)
    }
}
