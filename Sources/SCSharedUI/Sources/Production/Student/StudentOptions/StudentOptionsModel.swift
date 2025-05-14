import Foundation

public enum StudentOptionsType: Int, Codable {
    case none = -1
    case teachers = 0
    case attendance = 1
    case timeTable = 2
    case syllabus = 3
    case homework = 4
    case exams = 5
    case results = 6
    case fees = 7
    case events = 8
}

public struct StudentOptionsModel: Codable, Hashable {
    public let id: StudentOptionsType
    let title: String
    let icon: String
    let isSelected: Bool
    
    public static func == (lhs: StudentOptionsModel, rhs: StudentOptionsModel) -> Bool {
        return lhs.id == rhs.id
    }
}

