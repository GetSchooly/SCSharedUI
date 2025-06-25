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
    let apiClient = URLSessionAPIClient<ParentHomeEndpoint>()

    func getThoughtOfTheDay() -> AnyPublisher<ResponseModel<ThoughtOfTheDayModel>, Error> {
        return apiClient.request(.getRandomThought)
    }
}

// MARK: - Mock
extension ThoughtOfTheDayModel {
    static let mockThought = ThoughtOfTheDayModel(
        thought: "Education is the most powerful weapon you can use to change the world.",
        writtenBy: "Nelson Mandela"
    )
}
