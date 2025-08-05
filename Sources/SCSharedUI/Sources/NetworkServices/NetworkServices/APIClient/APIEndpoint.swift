import Foundation

public typealias APIEndpointFinal = APIEndpoint & APIEndpointHelpers

public protocol APIEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
}

public protocol APIEndpointHelpers {
    var headers: [String: String]? { get }
    var parameters: [String: Any?]? { get set }
}

struct DefaultEndpoint: APIEndpointFinal {
    public let baseURL: URL
    public let path: String
    public let method: HTTPMethod
    public let headers: [String: String]?
    public var parameters: [String : Any?]?
    public let body: Any?

    init(
        baseURL: URL = BaseURL.url,
        path: String,
        method: HTTPMethod,
        headers: [String: String]? = nil,
        parameters: [String: Any?]? = nil,
        body: Any? = nil
    ) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.headers = headers
        self.parameters = parameters
        self.body = body
    }
}
