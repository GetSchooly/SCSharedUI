import Foundation
import SCTokens
import Combine

struct ParentProfileOptionModel: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let image: Icons
}

public struct ParentProfileModel: Codable {
    let profileName: String?
    let profileImage: String?
    let profileEmail: String?

    var guradianDescription: String {
        return "guardian of one student"
    }
}

protocol ParentProfileServiceProtocol {
    func getParentProfile() -> AnyPublisher<ResponseModel<ParentProfileModel>, Error>
}

class ParentProfileService: ParentProfileServiceProtocol {
    let apiClient = URLSessionAPIClient()
    
    func getParentProfile() -> AnyPublisher<ResponseModel<ParentProfileModel>, Error> {
        return apiClient.request(ParentApiEndPoint.parentProfile())
    }
}

// MARK: - Mock
public extension ParentProfileModel {
    static let mockParent = ParentProfileModel(
        profileName: "John Doe",
        profileImage: "https://via.placeholder.com/150",
        profileEmail: "johndoe@example.com"
    )
}
