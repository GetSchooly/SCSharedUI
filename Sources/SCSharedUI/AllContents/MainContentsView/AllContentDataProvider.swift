import SwiftUI

struct ContentModel: Identifiable, Hashable {
        
    let id: Int
    let name: String
    let content: [Example]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: ContentModel, rhs: ContentModel) -> Bool {
        lhs.id == rhs.id
    }
}

enum AllContentViewType: String, CaseIterable, Identifiable {
    var id: Self {
        return self
    }
    
    case studentBasicProfile
    case userProfile
    case askdoutCard
}

extension AllContentViewType {
    var examples: [Example] {
        switch self {
        case .studentBasicProfile: StudentBasicProfileCardView.examples
        case .userProfile: UserProfileCardView.examples
        case .askdoutCard: AskDoubtCard.examples
        }
    }
    
    var index: Int {
        Self.allCases.firstIndex(of: self) ?? 0
    }
    
    var title: String {
        self.rawValue.capitalized
    }
}
