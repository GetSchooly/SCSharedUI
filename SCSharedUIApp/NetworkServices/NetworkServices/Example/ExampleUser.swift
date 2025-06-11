import Combine

public struct ExampleUser: Codable {
    let id: Int
    let name: String
}

public struct ExampleUserRequest: Codable {
    let id: Int
    let name: String
}

public protocol ExampleUserServiceProtocol {
    func getUsers() -> AnyPublisher<[ExampleUser], Error>
}

public class ExampleUserService: ExampleUserServiceProtocol {
    let apiClient = URLSessionAPIClient<SignInEndPoint>()

    public init() { }

    public func getUsers() -> AnyPublisher<[ExampleUser], Error> {
        let request = ExampleUserRequest(id: 1, name: "school app")
        return apiClient.request(.sendParentOtp, body: request)
    }
}
