import Foundation

public enum SignInEndPoint {
    public static func sendParentOtp() -> APIEndpointFinal {
        return DefaultEndpoint(
            path: "sendParentOtp",
            method: .post,
            headers: headers
        )
    }

    public static func verifyParentOtp() -> APIEndpointFinal {
        return DefaultEndpoint(
            path: "verifyParentOtp",
            method: .post,
            headers: headers
        )
    }
}

fileprivate var headers: [String: String]? {
    var headers: [String: String] = [:]
    headers["Content-Type"] = "application/json"
    return headers
}
