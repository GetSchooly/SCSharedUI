import Combine
import Foundation

class ThoughtOfTheDayViewModel: LoadableViewModel<ThoughtOfTheDayModel> {

    private lazy var thoughtOfTheDayService: ThoughtOfTheDayService = .init()
    private var cancellables: Set<AnyCancellable> = []
    private(set) var thoughtOfTheDay = ThoughtOfTheDayModel.mockThought
    
    // MARK:- Initialize
    override init() {
        super.init()
        observeThoughtUpdate()
    }
    
    // MARK: - Fetching functions
    func observeThoughtUpdate() {
        $loadingState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] loadingState in
                guard let self = self else { return }
                switch loadingState {
                case .loaded(let model):
                    self.thoughtOfTheDay = model
                default: break
                }
            }
            .store(in: &cancellables)
    }

    func fetchThoughtOfTheDay() -> AnyPublisher<ResponseModel<ThoughtOfTheDayModel>, Error> {
        thoughtOfTheDayService.getThoughtOfTheDay()
    }
}
