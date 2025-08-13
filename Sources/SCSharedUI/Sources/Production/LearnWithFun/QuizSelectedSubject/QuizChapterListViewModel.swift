import Foundation
import Combine

class QuizChapterListViewModel: LoadableViewModel<QuizChapterListModel> {
    private lazy var quizChapterListService = QuizChapterListService()
    private var cancellables: Set<AnyCancellable> = []
    private(set) var quizChapterListModel: QuizChapterListModel?
    @Published private(set) var chapters: [Chapter] = []

    override init() {
        super.init()
        quizChapterListModel = QuizChapterListModel.chapterListModel
        chapters = quizChapterListModel?.chapters ?? []
        observeQuizChapterList()
    }

    private func observeQuizChapterList() {
        $loadingState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] loadingState in
                guard let self else { return }
                switch loadingState {
                case .loaded(let model):
                    self.quizChapterListModel = model
                    self.chapters = model.chapters
                default: break
                }
            }
            .store(in: &cancellables)
    }

    func fetchQuizChapterList(subjectID: String) {
        guard let boardId = quizChapterListModel?.boardID else { return }

        let publisher = quizChapterListService.fetchQuizChapterList(subjectID: subjectID, boardID: boardId)
        load(publisher: publisher)
    }

    var subjectId: String? {
        quizChapterListModel?.subjectID
    }

    var chaptersTitle: [String] {
        chapters.map { $0.name }
    }
}
