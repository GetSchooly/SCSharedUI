import Foundation
import RealmSwift

open class GurardianModel: Object, Codable {
    @Persisted(primaryKey: true) public var gurardianEmailId: String
    @Persisted var token: String
    @Persisted var gurardianName: String
    
    enum CodingKeys: String, CodingKey {
        case gurardianEmailId = "GurardianEmailId"
        case token
        case gurardianName = "GurardianName"
    }
}
