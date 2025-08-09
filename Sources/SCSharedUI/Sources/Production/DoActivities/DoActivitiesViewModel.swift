import Foundation
import Combine

 class DoActivitiesViewModel: LoadableViewModel<DoActivitiesModel> {
    
     private lazy var childrenActivities: DoActivitiesViewService = DoActivitiesViewService()
     private var cancellables = Set<AnyCancellable>()
    // MARK:- Initialize
     
     @Published private(set) var activities: [Activities] = []
     
     override init() {
         super.init()
         self.activities = mockActivities
        observUpdateChildrenActivities()
    }
    
    // MARK: - Fetching functions
    func observUpdateChildrenActivities() {
        // Do something
        $loadingState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .loaded(let model):
                    self.activities = model.response
                default:
                    break
                }
            }
            .store(in: &cancellables)
    }
     
     func fetchChildrenActivities(limit:Int , offset:Int){
         let publicer = childrenActivities.fetchChildrenActivities(limit: 10, offset: 0)
         load(publisher: publicer)
     }
}

extension DoActivitiesViewModel {
    var mockActivities: [Activities] {
        Activities.mockActivities
    }
}
