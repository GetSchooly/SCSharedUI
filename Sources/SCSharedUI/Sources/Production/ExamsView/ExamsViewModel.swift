import Foundation
import SwiftUI
import Combine
 class ExamsViewModel: LoadableViewModel<ExamsModel> {
    @State var isPending: Bool = true
    let colors: [Color] = [Color.softPink, Color.softYellow, Color.fadedBlue, Color.lightGreen]  // 3 colors
    private lazy var studentExamScheduleService : StudentExamService = .init()
    private var cancellables: Set<AnyCancellable> = []
    @Published private(set) var examDetailList: [ExamDetails] = []
    @Published private(set) var completedExams: [ExamDetails] = []
    @Published private(set) var pendingExams: [ExamDetails] = []
    
    override init() {
        super.init()
        examDetailList = ExamsModel.mockExams.examList
        observeStudentExamsList()
    }
     
     private func observeStudentExamsList() {
         $loadingState
             .receive(on: DispatchQueue.main)
             .sink { [weak self] loadingState in
                 guard let self else { return }
                 switch loadingState {
                 case .loaded(let model):
                     examDetailList = model.examList
                     self.setExamsList()
                 default: break
                 }
             }
             .store(in: &cancellables)
     }
     
     private func setExamsList() {
         completedExams = examDetailList.compactMap { $0.isCompletedExam ? $0 : nil }
         pendingExams = examDetailList.compactMap { $0.isCompletedExam == false ? $0 : nil }
     }
     
     func fetchStudentExamBy(studentId: String, action:String){
         let publisher = studentExamScheduleService.fetchStudentExamBy(studentId: studentId, action: action)
         load(publisher: publisher)
     }
     
     
     
}


