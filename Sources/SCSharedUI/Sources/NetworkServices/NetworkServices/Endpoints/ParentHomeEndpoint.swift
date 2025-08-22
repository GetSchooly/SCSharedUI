import Foundation
import SCComponents
import SCTokens

public enum ParentApiEndPoint {
    static func parentProfile() -> APIEndpointFinal {
        return DefaultEndpoint(
            path: "viewEditLoginApp",
            method: .get,
            headers: headers
        )
    }

    static func randomThought() -> APIEndpointFinal {
        return DefaultEndpoint(
            path: "getRandomThought",
            method: .get,
            headers: headers
        )
    }

    static func registeredStudent() -> APIEndpointFinal {
        return DefaultEndpoint(
            path: "getAllRegisteredStudent",
            method: .get,
            headers: headers
        )
    }

    static func markedStudent() -> APIEndpointFinal {
        return DefaultEndpoint(
            path: "getAllMarkStudent",
            method: .get,
            headers: headers
        )
    }

    static func myChildren(studentIds: [String]) -> DefaultEndpoint {
        return DefaultEndpoint(
            path: "linkStudentandParent",
            method: .get,
            headers: headers,
            parameters: nil,
            body: ["studentIds": studentIds]
        )
    }

    static func eduBuddyRecentSession(userId: String) -> APIEndpointFinal {
        return DefaultEndpoint(
            path: "eduBuddySessions",
            method: .get,
            headers: headers,
            parameters: ["userId": userId]
        )
    }

    static func childrenActivities(limit:Int, offset:Int) -> APIEndpointFinal {
        return DefaultEndpoint(
            path: "getChildrenActivities",
            method: .get,
            headers: headers,
            parameters: ["limit": String(limit), "offset": String(offset)]
        )
    }

    static func todayReadList(limit:Int, offset:Int) -> APIEndpointFinal {
        return DefaultEndpoint(
            path: "getTodaysRead",
            method: .get,
            headers: headers,

            parameters: ["limit": String(limit), "offset": String(offset)]
        )

    }

    static func getTeachersByStudent(studentId: String) -> APIEndpointFinal {
        return DefaultEndpoint(
            path: "getStudentTeacher",
            method: .get,
            headers: headers,
            parameters: ["studentId": studentId]
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

