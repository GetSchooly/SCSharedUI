import Foundation

public struct AllHomeworkModel: Codable, Identifiable {
    public var id = UUID()
    let title: String
    let items: [String]
    
    public init(id: UUID = UUID(), title: String, items: [String]) {
        self.id = id
        self.title = title
        self.items = items
    }
}
