import Foundation
import SCComponents
import SCTokens

public enum StudentProfileEndPoint {
    static func getQuizSubjectsByClass(classId: String) -> APIEndpointFinal {
        return DefaultEndpoint(
            path: "getQuizSubjectsByClass",
            method: .get,
            headers: headers,
            parameters: ["classId": classId]
        )
    }

    static func getChaptersBySubjectId(subjectId: String, boardId: String) -> APIEndpointFinal {
        return DefaultEndpoint(
            path: "getChaptersBySubjectId",
            method: .get,
            headers: headers,
            parameters: ["subjectId": subjectId, "boardId": boardId]
        )
    }

    static func getQuizQuestionsByQuizFor(boardId: String, subjectUniqueId: String, chapterId: String) -> APIEndpointFinal {
        return DefaultEndpoint(
            path: "getQuizQuestionsByQuiz",
            method: .get,
            headers: headers,
            parameters: [
                "quizUniqueId": "\(boardId.lowercased())-\(subjectUniqueId.lowercased())-\(chapterId)",
                "limit": Int.random(in: 7...15)
            ]
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
