import Combine
import Foundation

protocol FindMyChildrenViewModelService {
    var mychildrenService: MyChildrenViewService { get set }
    var cancellables: Set<AnyCancellable> { get set }
    func observeChildren()
}

class FindYourChildrenModel: LoadableViewModel<MyChildrenModel>, FindMyChildrenViewModelService {

    lazy var mychildrenService: MyChildrenViewService = MyChildrenViewService()
    var cancellables = Set<AnyCancellable>()

    @Published var markedChildren: [StudentData] = []
    
    override init() {
        super.init()
        self.markedChildren = mockStudents
        observeChildren()
    }

    internal func observeChildren() {
        $loadingState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .loaded(let model):
                    self.markedChildren = mockStudents //model.studentData
                default:
                    break
                }
            }
            .store(in: &cancellables)
    }

    func fetchAllregisteredStudents() {
        let publisher = mychildrenService.fetchAllRegisteredChildren()
        load(publisher: publisher)
    }
}

class LinkChildViewModel: LoadableViewModel<EmptyDataModel>, FindMyChildrenViewModelService {
    var mychildrenService: MyChildrenViewService = MyChildrenViewService()
    let service = MyChildrenViewService()
    var cancellables = Set<AnyCancellable>()
    private var childIds: [String] = []
    
    override init() {
        super.init()
        observeChildren()
    }

    func observeChildren() {
        $loadingState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                switch state {
                case .loaded(let model):
                    break
                default:
                    break
                }
            }
            .store(in: &cancellables)
    }
    
    func addChildIdToTrack(_ childId: Int) {
        let id = String(childId)
        if childIds.contains(id) {
            childIds.removeAll { _id in
                return _id == id
            }
        } else {
            childIds.append(id)
        }
    }
    
    func linkChildredToParent() {
        if !childIds.isEmpty {
            let publisher = service.linkChildToParent(childIds)
            load(publisher: publisher)
        }
    }
}

//MARK: - Shimmering
extension FindMyChildrenViewModelService {
    var mockStudents: [StudentData] {
        StudentData.mockStudents
    }
}
