import Foundation
import SCTokens

struct ParentProfileModel: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let image: Icons
}

