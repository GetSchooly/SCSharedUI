import Foundation
import Combine

// MARK: - QuizChapterListModel
struct QuizChapterListModel: Codable {
    let subjectID, boardID: String
    let chapters: [Chapter]

    enum CodingKeys: String, CodingKey {
        case subjectID = "subjectId"
        case boardID = "boardId"
        case chapters
    }
}

// MARK: - Chapter
struct Chapter: Codable {
    let chapterID, name: String
    let boardID: BoardID

    enum CodingKeys: String, CodingKey {
        case chapterID = "chapterId"
        case name
        case boardID = "boardId"
    }
}

enum BoardID: String, Codable {
    case cbse = "CBSE"
    case icse = "ICSE"
    case state = "STATE"
}

protocol QuizChapterListServiceProtocol {
    func fetchQuizChapterList(subjectID: String, boardID: String) -> AnyPublisher<ResponseModel<QuizChapterListModel>, Error>
}

class QuizChapterListService: QuizChapterListServiceProtocol {
    let apiClient = URLSessionAPIClient()

    func fetchQuizChapterList(subjectID: String, boardID: String) -> AnyPublisher<ResponseModel<QuizChapterListModel>, Error> {
        let endPoint = StudentProfileEndPoint.getChaptersBySubjectId(subjectId: subjectID, boardId: boardID)
        return apiClient.request(endPoint)
    }
}

// MARK: - Mock
extension QuizChapterListModel {
    static let chapterListModel: QuizChapterListModel = .init(
        subjectID: "1-maths",
        boardID: "CBSE",
        chapters: [
            .init(chapterID: "1-maths", name: "Chapter 1", boardID: .cbse),
            .init(chapterID: "1-maths", name: "Chapter 2", boardID: .icse),
            .init(chapterID: "1-maths", name: "Chapter 3", boardID: .cbse),
            .init(chapterID: "1-maths", name: "Chapter 4", boardID: .cbse),
            .init(chapterID: "1-maths", name: "Chapter 5", boardID: .icse),
            .init(chapterID: "1-maths", name: "Chapter 6", boardID: .cbse)
        ]
    )
}
 
