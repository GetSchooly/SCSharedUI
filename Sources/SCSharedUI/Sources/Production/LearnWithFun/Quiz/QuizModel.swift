import Foundation
import Combine

// MARK: - QuizModel
struct QuizModel: Codable {
    let id: Int
    let quizUniqueID, question: String
    let options: [String]
    let correctOption: Int
    let answer, explanation: String
    let questionType: QuestionType
    let difficulty: Difficulty
    let imageURL: String?
    let board: String
    var selectedAnswerIndex: Int? = nil

    enum CodingKeys: String, CodingKey {
        case id
        case quizUniqueID = "quizUniqueId"
        case question, options, correctOption, answer, explanation
        case imageURL = "imageUrl"
        case questionType
        case difficulty
        case board
    }
}

enum QuestionType: String, Codable {
    case mcq = "MCQ"
    case trueFalse = "TRUE-FALSE"
}

protocol QuizServiceProtocol {
    func fetchQuiz(quizUniqueId: String) -> AnyPublisher<ResponseModel<[QuizModel]>, Error>
}

class QuizService: QuizServiceProtocol {
    let apiClient = URLSessionAPIClient()

    func fetchQuiz(quizUniqueId: String) -> AnyPublisher<ResponseModel<[QuizModel]>, Error> {
        let endPoint = StudentProfileEndPoint.getQuizQuestionsByQuizFor(quizUniqueId: quizUniqueId)
        return apiClient.request(endPoint)
    }
}

// MARK: - Mock
extension QuizModel {
    static let mockQuizQuestions: [QuizModel] = [
        .init(
            id: 1,
            quizUniqueID: "quizUniqueID",
            question: "What is the limit of sin(x)/x as x approaches 0?",
            options: [
                "0",
                "1",
                "Infinity",
                "Does not exist"
            ],
            correctOption: 1,
            answer: "1",
            explanation: "lim(x→0) sin(x)/x = 1.",
            questionType: .mcq,
            difficulty: .easy,
            imageURL: nil,
            board: "CBSE"
        ),
        .init(
            id: 2,
            quizUniqueID: "quizUniqueID",
            question: "limit of sin(x)/x as x approaches 1?",
            options: [
                "0.5",
                "0",
                "1",
                "Noe of them above"
            ],
            correctOption: 1,
            answer: "1",
            explanation: "lim(x→0) sin(x)/x = 1.",
            questionType: .mcq,
            difficulty: .easy,
            imageURL: nil,
            board: "CBSE"
        )
    ]
}
