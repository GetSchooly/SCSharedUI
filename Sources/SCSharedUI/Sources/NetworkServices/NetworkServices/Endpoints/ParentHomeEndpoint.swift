import Foundation
import SCComponents

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
        // swiftlint:disable:next line_length
        if let bearerToken = bearerToken {
            headers["Authorization"] = "Bearer Token \(bearerToken)"
        }

        switch self {
        case .getAllMarkStudent, .getAllRegisteredStudent:
            headers["Content-Type"] = "application/json"
        }

        return headers
    }

    public var parameters: [String: Any?]? {
        return nil
    }

    private var bearerToken: String? {
        let gurardianEmailId = UserDefaultsManager.shared.gurardianEmailId
        let predicate = NSPredicate(format: "gurardianEmailId == %@", gurardianEmailId ?? "")
        return DBManager.shared.fetch(GurardianModel.self, filter: predicate).first?.token
    }
}
