import Combine
import UIKit
import Foundation

class TeacherListViewModel: LoadableViewModel<TeacherListModel> {
    private lazy var teacherListService = TeacherListViewService()
    private var cancellables: Set<AnyCancellable> = []
    @Published var teacherList: TeacherListModel?

    override init() {
        super.init()
        teacherList = mockTeachers
        observeUpdateMarkedChildren()
    }

    var classTeacher: TeacherProfile? {
        teacherList?.studentTask.first
    }

    var otherTeachers: [TeacherProfile] {
        guard let teachers = teacherList?.studentTask, teachers.count > 1 else {
            return []
        }

        return Array(teachers.dropFirst())
    }

    private func observeUpdateMarkedChildren() {
        $loadingState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .loaded(let model):
                    self.teacherList = model
                    break
                default:
                    break
                }
            }
            .store(in: &cancellables)
    }

    func fetchStudentTeachersBy(_ studentId: String) {
        let publisher = teacherListService.getTeacherListBy(studentId: studentId)
        load(publisher: publisher)
    }

    func handleTeacherContactAction(_ option: ContactOption, contact: String) {
        if option == .call,
           let url = URL(string: "tel://\(contact)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else if option == .chat {
            // TODO: - chat contact - open inbox
        }
    }
}

//MARK: - Shimmering
private extension TeacherListViewModel {
    var mockTeachers: TeacherListModel {
        TeacherListModel.mockTechers
    }
}
