import Foundation
import Combine

struct ThoughtOfTheDayModel: Codable {
    let thought: String
    let writtenBy: String
}

protocol ThoughtOfDayServiceProtocol {
    func getThoughtOfTheDay() -> AnyPublisher<ResponseModel<ThoughtOfTheDayModel>, Error>
}

class ThoughtOfTheDayService: ThoughtOfDayServiceProtocol {
    let apiClient = URLSessionAPIClient()

    func getThoughtOfTheDay() -> AnyPublisher<ResponseModel<ThoughtOfTheDayModel>, Error> {
        let endPoint = ParentApiEndPoint.randomThought()
        return apiClient.request(endPoint)
    }
}

// MARK: - Mock
extension ThoughtOfTheDayModel {
    static let mockThought = ThoughtOfTheDayModel(
        thought: "Education is the most powerful weapon you can use to change the world.",
        writtenBy: "Nelson Mandela"
    )
}
