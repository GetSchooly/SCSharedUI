import Foundation

public struct StudentOptionsModel: Codable, Hashable {
    let id: Int
    let title: String
    let icon: String
    let isSelected: Bool
    
    public static func == (lhs: StudentOptionsModel, rhs: StudentOptionsModel) -> Bool {
        return lhs.id == rhs.id
    }
}

