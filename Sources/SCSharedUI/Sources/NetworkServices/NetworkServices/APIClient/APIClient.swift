import Combine

public protocol APIClient {
    associatedtype EndpointType: APIEndpoint
    func request<T: Decodable, U: Encodable>(_ endpoint: EndpointType, body: U?) -> AnyPublisher<T, Error>
}
