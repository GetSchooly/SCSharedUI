import Foundation
import Combine
import SCTokens

class ParentProfileViewModel: LoadableViewModel<ParentProfileModel> {

    private lazy var parentProfileService: ParentProfileService = ParentProfileService()
    private var cancellables: Set<AnyCancellable> = []

    var profileModel: ParentProfileModel?

    var tabSettingsItems: [ParentProfileOptionModel] = [
        ParentProfileOptionModel(title: "Subscription", image: Icons.ic_Subscribe),
        ParentProfileOptionModel(title: "Language", image: Icons.ic_lang)
    ]

    var tabOtherItems: [ParentProfileOptionModel] = [
        ParentProfileOptionModel(title: "Support/FAQ", image: Icons.ic_Support),
        ParentProfileOptionModel(title: "Logout", image: Icons.ic_Logout)
    ]

    // MARK:- Initialize
    override init() {
        super.init()
        observeParentProfile()
    }

    // MARK: - Fetching functions
   private func observeParentProfile() {
        $loadingState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .loaded(let model):
                    self.profileModel = model
                default:
                    break
                }
            }
            .store(in: &cancellables)
    }

    func fetchParentProfile() -> AnyPublisher<ResponseModel<ParentProfileModel>, Error>  {
        parentProfileService.getParentProfile()
    }
}
