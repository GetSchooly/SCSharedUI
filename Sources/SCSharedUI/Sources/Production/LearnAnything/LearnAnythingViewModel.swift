import Foundation
import Combine

public class LearnAnythingViewModel: LoadableViewModel<[LearnAnythingModel]> {
    private lazy var eduBuddyService: LearnAnythingViewService = LearnAnythingViewService()
    private var cancellables = Set<AnyCancellable>()

    @Published private(set) var recentSessions: [LearnAnythingModel] = []

    override init() {
        super.init()
        recentSessions = mockRecents
        observeRecentEduBuddySessions()
    }

    private func observeRecentEduBuddySessions() {
        $loadingState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self else { return }
                switch state {
                case .loaded(let model):
                    self.recentSessions = model
                default:
                    break
                }
            }
            .store(in: &cancellables)
    }

    func fetchAllRecentSessionByUserId(_ userId: String) {
        let publisher = eduBuddyService.fetchRecentSessions(userId: userId)
        load(publisher: publisher)
    }
}

//MARK: - Shimmering
extension LearnAnythingViewModel {
    var mockRecents: [LearnAnythingModel] {
        LearnAnythingModel.mockSessions
    }
}
