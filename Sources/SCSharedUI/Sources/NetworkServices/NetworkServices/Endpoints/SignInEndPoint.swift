import Foundation

public enum SignInEndPoint: APIEndpoint {

    case sendParentOtp
    case verifyParentOtp

    public var baseURL: URL {
        return BaseURL.url
    }

    public var path: String {
        switch self {
        case .sendParentOtp:
            return "sendParentOtp"
        case .verifyParentOtp:
            return "verifyParentOtp"
        }
    }

    public var method: HTTPMethod {
        switch self {
        case .sendParentOtp, .verifyParentOtp:
            return .post
        }
    }
}

extension SignInEndPoint: APIEndpointHelpers {

    public var headers: [String: String]? {
        switch self {
        case .sendParentOtp, .verifyParentOtp:
            return [:]
        }
    }

    public var parameters: [String: Any?]? {
        return nil
    }
}
