import SwiftUI
import SCComponents
import SCTokens

public struct TeachersListView: View {
    @StateObject var viewModel = TeacherListViewModel()
    @Environment(\.mainWindowSize) var mainWindowSize
    @State private var refreshID = UUID()
    private let studentId: String
    private var onTapATeacher: ((TeacherProfile) -> Void)?
    
    public init(studentId: String, onTapATeacher: ((TeacherProfile) -> Void)? = nil) {
        self.studentId = studentId
        self.onTapATeacher = onTapATeacher
    }

    public var body: some View {
        Group {
            switch viewModel.loadingState.viewLoadingState {
            case .idle, .loading:
                studentTeachersList
                    .shimmer(isLoading: true)

            case .loaded:
                studentTeachersList

            case .failed(let error):
                LoadingViewHelper.errorView(errorMessage: error.localizedDescription) {
                    refreshID = UUID()
                }
            }
        }
        .task {
            viewModel.fetchStudentTeachersBy(studentId)
        }
    }

    private var studentTeachersList: some View {
        ScrollView {
            Spacer(minLength: Spacing.spacing5x)
            VStack(spacing: Spacing.spacing4x) {
                if let classTeacher = viewModel.classTeacher {
                    TeacherProfileCard(
                        teacher: classTeacher,
                        teacherType: "Class/\(classTeacher.subjectName)",
                        onTap: { option, contact in
                            self.viewModel.handleTeacherContactAction(option, contact: contact)
                        }
                    )
                    .frame(width: mainWindowSize.width/2)
                }
                
                if !viewModel.otherTeachers.isEmpty {
                    subjectTeachersList()
                }
            }
        }
    }

    private let columns: [GridItem] = [GridItem(.flexible()),
                                       GridItem(.flexible())]
    private func subjectTeachersList() -> some View {
        VStack(alignment: .leading) {
            SDText(
                "Subject wise",
                style: .size200(
                    weight: .semiBold,
                    theme: .primary,
                    alignment: .leading
                )
            )
            .frame(height: Sizing.sizing10x)

            LazyVGrid(columns: columns){
                ForEach(viewModel.otherTeachers){ teacher in
                    TeacherProfileCard(
                        teacher: teacher,
                        teacherType: nil,
                        onTap: { option, contact in
                            self.viewModel.handleTeacherContactAction(option, contact: contact)
                        }
                    )
                    .frame(width: mainWindowSize.width/2.4)
                    .padding(.trailing, Spacing.spacing1x)
                    .padding(.vertical, Spacing.spacing4x)
                }
            }
        }
        .padding(.horizontal, Spacing.spacing4x)
    }
}

#Preview {
    TeachersListView(studentId: "")
        .environment(\.mainWindowSize, UIScreen.main.bounds.size)
}
