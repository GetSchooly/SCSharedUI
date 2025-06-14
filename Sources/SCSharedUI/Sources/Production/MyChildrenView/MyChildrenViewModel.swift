import Combine

class MyChildrenViewModel: LoadableViewModel<MyChildrenModel> {
    
    private lazy var mychildrenService: MyChildrenViewService = MyChildrenViewService()
    
    func fetchAllregisteredStudents() {
        let publisher = mychildrenService.fetchAllRegisteredChildren()
        load(publisher: publisher)
    }
}
