import Foundation

public struct ResponseModel<Response: Codable>: Codable {
    public let meta: Meta
    public let response: Response?

    enum CodingKeys: CodingKey {
        case meta
        case response
    }
}

public struct Meta: Codable {
    public let success: Bool
    public let successMessage, message: String?
    public let statusCode: Int?

    enum CodingKeys: CodingKey {
        case success
        case successMessage
        case message
        case statusCode
    }
}
