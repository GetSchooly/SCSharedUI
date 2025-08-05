import Foundation
import Combine

public struct LearnAnythingModel: Codable {
    let id: Int
    let userID, sessionID, question, askedOn: String
    let sessionTime: String

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case sessionID = "sessionId"
        case question, askedOn, sessionTime
    }
}

protocol LearnAnythingServiceProtocol {
    func fetchRecentSessions(userId: String) -> AnyPublisher<ResponseModel<[LearnAnythingModel]>, Error>
}

class LearnAnythingViewService: LearnAnythingServiceProtocol {
    let apiClient = URLSessionAPIClient()
    
    func fetchRecentSessions(userId: String) -> AnyPublisher<ResponseModel<[LearnAnythingModel]>, Error> {
        let endPoint = ParentApiEndPoint.eduBuddyRecentSession(userId: userId)
        return apiClient.request(endPoint)
    }
}

// MARK: - Mock

public extension LearnAnythingModel {
    static var mockSessions: [LearnAnythingModel] {
        [
            .init(
                id: 1,
                userID: "1",
                sessionID: "1",
                question: "What is Swift? How does it work?",
                askedOn: "2025-07-28T11:00:58.425488Z",
                sessionTime: "2025-07-28T11:00:58.425488Z"
            ),
            .init(
                id: 2,
                userID: "1",
                sessionID: "1",
                question: "Newton's Law of Universal Gravitation?",
                askedOn: "2025-07-28T11:00:58.425488Z",
                sessionTime: "2025-07-28T11:00:58.425488Z"
            ),
            .init(
                id: 3,
                userID: "1",
                sessionID: "1",
                question: "History of Indian independence in 1947?",
                askedOn: "2025-07-28T11:00:58.425488Z",
                sessionTime: "2025-07-28T11:00:58.425488Z"
            ),
            .init(
                id: 4,
                userID: "1",
                sessionID: "1",
                question: "Who was space race champion in 1969?",
                askedOn: "2025-07-28T11:00:58.425488Z",
                sessionTime: "2025-07-28T11:00:58.425488Z"
            ),
            .init(
                id: 5,
                userID: "1",
                sessionID: "1",
                question: "Geopolitics of Romania?",
                askedOn: "2025-07-28T11:00:58.425488Z",
                sessionTime: "2025-07-28T11:00:58.425488Z"
            )
        ]
    }
}
