import Foundation

public typealias APIEndpointFinal = APIEndpoint & APIEndpointHelpers

public protocol APIEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
}

public protocol APIEndpointHelpers {
    var headers: [String: String]? { get }
    var parameters: [String: Any?]? { get }
}
