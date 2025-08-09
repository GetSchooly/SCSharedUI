import Combine
import Foundation

class MyChildrenViewModel: LoadableViewModel<MyChildrenModel> {
    private lazy var mychildrenService: MyChildrenViewService = MyChildrenViewService()
    private var cancellables = Set<AnyCancellable>()
    @Published private(set) var markedChildren: [StudentData] = []
    @Published private(set) var shoudlFindChildren: Bool = false
    
    override init() {
        super.init()
        self.markedChildren = mockStudents
        observeUpdateMarkedChildren()
    }

    private func observeUpdateMarkedChildren() {
        $loadingState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .loaded(let model):
                    self.markedChildren = model.studentData
                    self.shoudlFindChildren = self.markedChildren.isEmpty
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

    func fetchAllMarkedChildren() -> AnyPublisher<ResponseModel<MyChildrenModel>, Error> {
        return mychildrenService.fetchAllMarkedChildren()
    }
}

//MARK: - Shimmering
private extension MyChildrenViewModel {
    var mockStudents: [StudentData] {
        StudentData.mockStudents
    }
}
