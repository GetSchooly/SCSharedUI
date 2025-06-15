import Foundation
import SCComponents
import SCTokens

public enum ParentHomeEndpoint: APIEndpoint {

    case getAllRegisteredStudent
    case getAllMarkStudent

    public var baseURL: URL {
        BaseURL.url
    }

    public var path: String {
        switch self {
        case .getAllRegisteredStudent:
            return "getAllRegisteredStudent"
        case .getAllMarkStudent:
            return "getAllMarkStudent"
        }
    }

    public var method: HTTPMethod {
        switch self {
        case .getAllMarkStudent, .getAllRegisteredStudent:
            return .get
        }
    }
}

extension ParentHomeEndpoint: APIEndpointHelpers {

    public var headers: [String: String]? {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"

        switch self {
        case .getAllMarkStudent, .getAllRegisteredStudent:
            if let bearerToken = bearerToken {
                headers["Authorization"] = "Bearer \(bearerToken)"
            }
        }

        return headers
    }

    public var parameters: [String: Any?]? {
        return nil
    }

    private var bearerToken: String? {
        let tokenResult = Keychain.shared.readString(forKey: .token)
        switch tokenResult {
        case .success(let token):
            return token
        case .failure(_):
            return nil
        }
    }
}
