import Foundation

public enum APIError: Error {
    case noResponse
    case internalServerError
    case badRequest
    case unauthorized
    case forbidden
    case resourceNotFound
    case methodNotAllowed
    case unprocessableEntity
    case dataNotEncodable
    case invalidURL(url: String)
    case other(reason: Error)
    case serverError(reason: String)
    case noStatusCodeFound
    case sessionExpired
    case verifyEmail
    case unknown
    case invalidResponseFormat
    case userNameExsiting

    /*
     What follows is the representations
     of invalid status codes that the server
     may return in its response
     */

    public static func fromStatusCode(code: Int) -> APIError? {
        switch code {
        case 200: return nil
        case 204: return nil
        case 400: return .badRequest
        case 401: return .sessionExpired
        case 403: return .forbidden
//        case 404: return .resourceNotFound
        case 405: return .methodNotAllowed
        case 422: return .unprocessableEntity
        case 500: return .internalServerError
//        case 1001: return .verifyEmail
//        case 105 : return .userNameExsiting

        default:
            return nil
        }
    }

    public var code: Int? {
        switch self {
        case .internalServerError: return 500
        case .badRequest: return 400
        case .unauthorized, .dataNotEncodable, .serverError(_), .invalidURL(_), .other(_), .noStatusCodeFound, .unknown, .invalidResponseFormat, .noResponse: return nil
        case .forbidden: return 403
        case .resourceNotFound: return 404
        case .methodNotAllowed: return 405
        case .unprocessableEntity: return 422
        case .sessionExpired: return 401
        case .verifyEmail: return 1001
        case .userNameExsiting: return 105
        }
    }
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .internalServerError:
            return "Strings.internalServerError.localizedValue"
        case .badRequest:
            return "Strings.badRequest.localizedValue"
        case .unauthorized:
            return "Strings.unauthorized.localizedValue"
        case .forbidden:
            return "Strings.forbidden.localizedValue"
        case .resourceNotFound:
            return "Strings.resourceNotFound.localizedValue"
        case .methodNotAllowed:
            return "Strings.methodNotAllowed.localizedValue"
        case .unprocessableEntity:
            return "Strings.uprocessableEntity.localizedValue"
        case .dataNotEncodable:
            return "Strings.dataNotEncodable.localizedValue"
        case .invalidURL:
            return "Strings.invalidURL.localizedValue"
        case .other(reason: let error):
            return error.localizedDescription
        case .noStatusCodeFound:
            return "Strings.noStatusCodeFound.localizedValue"
        case .sessionExpired:
            return "Strings.sessionExpired.localizedValue"
        case .unknown:
            return "Strings.unknown.localizedValue"
        case .invalidResponseFormat:
            return "Strings.invalidResponseFormat.localizedValue"
        case .verifyEmail:
            return "1001"
        case .serverError(let reason):
            return reason
        case .userNameExsiting:
            return "Strings.userNameExsiting.localizedValue"
        case .noResponse:
            return "Response not available"
        }
    }
}
