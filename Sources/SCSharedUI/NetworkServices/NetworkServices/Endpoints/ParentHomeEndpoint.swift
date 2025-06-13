import Foundation

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
        headers["Bearer Token"] = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzUyMDgwMjg0LCJpYXQiOjE3NDk0ODgyODQsImp0aSI6IjNjZjZlZjc4YTJkZTRiZjhhOTcyYzhmYjVmODBjM2FjIiwidXNlcl9pZCI6MTY2fQ.eo0EbBq-R5v-Utp4x8dSnuP8_lFzlNuRUNP7vwIjHPE"

        switch self {
        case .getAllMarkStudent, .getAllRegisteredStudent:
            headers["Content-Type"] = "application/json"
        }

        return headers
    }

    public var parameters: [String: Any?]? {
        return nil
    }
}
