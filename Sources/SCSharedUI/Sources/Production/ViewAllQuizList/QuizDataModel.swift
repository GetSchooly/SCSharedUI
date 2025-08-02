
import Foundation

struct QuizDataModel: Codable, Identifiable, Hashable {
    var id = UUID()
    let name: String
    let lastMessage: String
}
