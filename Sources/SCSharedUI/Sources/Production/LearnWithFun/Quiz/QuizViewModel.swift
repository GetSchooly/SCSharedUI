import Foundation
import Combine

class QuizViewModel: LoadableViewModel<[QuizModel]> {
    private lazy var quizService = QuizService()
    private lazy var cancellables: Set<AnyCancellable> = []
    @Published var quizQuestions: [QuizModel] = []

    override init() {
        super.init()
        quizQuestions = QuizModel.mockQuizQuestions
        observeQuizQuestionsList()
    }

    private func observeQuizQuestionsList() {
        $loadingState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] loadingState in
                guard let self else { return }
                switch loadingState {
                case .loaded(let model):
                    self.quizQuestions = model
                default: break
                }
            }
            .store(in: &cancellables)
    }

    func fetchQuizQuestions(quizUniqueId: String) {
        let publisher = quizService.fetchQuiz(quizUniqueId: quizUniqueId)
        load(publisher: publisher)
    }

    func setSelectedAnswer(for questionIndex: Int, answerIndex: Int) {
        quizQuestions[questionIndex].selectedAnswerIndex = answerIndex
    }

    func isAnswerCorrect(for question: QuizModel) -> Bool {
        guard let selectedAnswerIndex = question.selectedAnswerIndex else {
            return false
        }
        let answer = question.options[selectedAnswerIndex]
        return answer == question.answer
    }

    var gainedScore: Int {
        return quizQuestions.filter { model in
            guard let selectedAnswerIndex = model.selectedAnswerIndex else {
                return false
            }
            return selectedAnswerIndex == model.correctOption
        }.count
    }

    var totalScore: Int {
        return quizQuestions.count
    }
}
