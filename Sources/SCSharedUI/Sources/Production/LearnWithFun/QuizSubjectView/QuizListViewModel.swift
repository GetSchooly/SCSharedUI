import Foundation
import Combine

class QuizSubjectsViewModel: LoadableViewModel<[QuizSubjectModel]> {
    private lazy var quizSubjectsService: QuizSubjectsService = .init()
    private var cancellables: Set<AnyCancellable> = []
    @Published private(set) var quizSubjects: [QuizSubjectModel] = []
    @Published var selectedSubject: QuizSubjectModel?

    override init() {
        super.init()
        quizSubjects = QuizSubjectModel.mockSubjects
        observeQuizSubjects()
    }

    private func observeQuizSubjects() {
        $loadingState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] loadingState in
                guard let self else { return }
                switch loadingState {
                case .loaded(let subjects):
                    self.quizSubjects = subjects
                default: break
                }
            }
            .store(in: &cancellables)
    }

    func fetchQuizSubjects(classID: Int) {
        let publisher = quizSubjectsService.fetchQuizSubjectsBy(classID: classID)
        load(publisher: publisher)
    }

    func setQuizSubjects(_ subjects: [QuizSubjectModel]) {
        self.quizSubjects = subjects
    }

    func selectedSubject(_ subject: QuizSubjectModel) {
        selectedSubject = subject
    }
}
