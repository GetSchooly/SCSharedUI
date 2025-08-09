import Foundation
import SCComponents
import SCTokens

public enum StudentProfileEndPoint {
    static func getQuizSubjectsByClassBy(classId: String) -> APIEndpointFinal {
        return DefaultEndpoint(
            path: "getQuizSubjectsByClass",
            method: .get,
            headers: headers,
            parameters: ["classId": classId]
        )
    }

    static func getChaptersBySubjectId(subjectId: String) -> APIEndpointFinal {
        return DefaultEndpoint(
            path: "getChaptersBySubjectId",
            method: .get,
            headers: headers,
            parameters: ["subjectId": subjectId]
        )
    }
}

fileprivate var headers: [String: String]? {
    var headers: [String: String] = [:]
    headers["Content-Type"] = "application/json"

    let tokenResult = Keychain.shared.readString(forKey: .token)
    if case .success(let token) = tokenResult {
        headers["Authorization"] = "Bearer \(token)"
    }

    return headers
}
