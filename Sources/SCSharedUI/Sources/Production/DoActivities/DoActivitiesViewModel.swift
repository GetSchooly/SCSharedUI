import Foundation
import Combine

 class DoActivitiesViewModel: LoadableViewModel<[DoActivitiesModel]> {
     private lazy var childrenActivities: DoActivitiesViewService = DoActivitiesViewService()
     private var cancellables = Set<AnyCancellable>()
     @Published private(set) var activities: [DoActivitiesModel] = []

     override init() {
         super.init()
         self.activities = mockActivities
         observUpdateChildrenActivities()
     }

     private func observUpdateChildrenActivities() {
         $loadingState
             .receive(on: DispatchQueue.main)
             .sink { [weak self] state in
                 guard let self = self else { return }
                 switch state {
                 case .loaded(let model):
                     self.activities = model
                 default:
                     break
                 }
             }
             .store(in: &cancellables)
     }

     func fetchChildrenActivities(limit:Int, offset:Int) {
         let publisher = childrenActivities.fetchChildrenActivities(limit: limit, offset: offset)
         load(publisher: publisher)
     }
}

extension DoActivitiesViewModel {
    var mockActivities: [DoActivitiesModel] {
        DoActivitiesModel.mockActivities
    }
}
