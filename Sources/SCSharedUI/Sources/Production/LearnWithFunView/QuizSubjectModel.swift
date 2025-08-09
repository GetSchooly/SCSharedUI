import Foundation
import Combine

public struct QuizSubjectModel: Codable, Identifiable, Hashable {
    public let id: Int
    public let title: String
    public let attemptedCount: Int
    public let uniqueID, icon: String
    public let classID: Int

    enum CodingKeys: String, CodingKey {
        case id, title, attemptedCount
        case uniqueID = "uniqueId"
        case icon
        case classID = "classId"
    }
}

protocol QuizSubjectsServiceProtocol {
    func fetchQuizSubjectsBy(classID: Int) -> AnyPublisher<ResponseModel<[QuizSubjectModel]>, Error>
}

class QuizSubjectsService: QuizSubjectsServiceProtocol {
    let apiClient = URLSessionAPIClient()

    func fetchQuizSubjectsBy(classID: Int) -> AnyPublisher<ResponseModel<[QuizSubjectModel]>, Error> {
        let endPoint = StudentProfileEndPoint.getQuizSubjectsByClass(classId: String(classID))
        return apiClient.request(endPoint)
    }
}

// MARK: - Mock
extension QuizSubjectModel {
    static let mockSubject: QuizSubjectModel = .init(
        id: 1,
        title: "English",
        attemptedCount: 123,
        uniqueID: "1-English",
        icon: "english.png",
        classID: 1
    )

    static let mockSubjects: [QuizSubjectModel] = [
        .init(
            id: 1,
            title: "English",
            attemptedCount: 123,
            uniqueID: "1-English",
            icon: "english.png",
            classID: 1
        ),
        .init(
            id: 2,
            title: "English",
            attemptedCount: 123,
            uniqueID: "1-English",
            icon: "english.png",
            classID: 1
        ),
        .init(
            id: 3,
            title: "English",
            attemptedCount: 123,
            uniqueID: "1-English",
            icon: "english.png",
            classID: 1
        ),
        .init(
            id: 1,
            title: "English",
            attemptedCount: 123,
            uniqueID: "1-English",
            icon: "english.png",
            classID: 1
        )
    ]
}
