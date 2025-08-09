import SwiftUI
import SCTokens
import SCComponents

public enum QuizSubjectLayout {
    case home
    case detail(subjects: [QuizSubjectModel] = [])
}

public struct QuizSubjectView: View {
    @StateObject private var viewModel: QuizSubjectsViewModel = QuizSubjectsViewModel()
    private let columns = [
        GridItem(.flexible(), spacing: Spacing.spacing4x),
        GridItem(.flexible(), spacing: Spacing.spacing4x)
    ]
    private let classID: Int
    private let pageLayout: QuizSubjectLayout
    private let onTapSubject: ((QuizSubjectModel) -> Void)?
    private let onTapSeeAll:(([QuizSubjectModel]) -> Void)?

    public init(
        classID: Int,
        pageLayout: QuizSubjectLayout = .home,
        onTapSubject: ((QuizSubjectModel) -> Void)? = nil,
        onTapSeeAll: (([QuizSubjectModel]) -> Void)? = nil
    ) {
        self.classID = classID
        self.pageLayout = pageLayout
        self.onTapSubject = onTapSubject
        self.onTapSeeAll = onTapSeeAll
    }

    public var body: some View {
        Group {
            switch pageLayout {
            case .home:
                quizHomeView
            case .detail(let subjects):
                quizDetailLayout
                    .onAppear {
                        viewModel.setQuizSubjects(subjects)
                    }
            }
        }
    }

    private var quizHomeView: some View {
        Group {
            switch viewModel.loadingState.viewLoadingState {
            case .idle, .loading:
                LearnWithFunHomeView(viewModel: viewModel)
                    .shimmer(isLoading: true)

            case .loaded:
                LearnWithFunHomeView(viewModel: viewModel) {
                    onTapSeeAll?(viewModel.quizSubjects)
                }

            case .failed(_):
                EmptyView()
            }
        }
        .task {
            viewModel.fetchQuizSubjects(classID: classID)
        }
    }

    private var quizDetailLayout: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: Spacing.spacing4x) {
                subjectView
            }
            .padding(.horizontal, Spacing.spacing4x)
        }
    }

    private var subjectView: some View {
        ForEach(viewModel.quizSubjects) { subject in
            LearnWithFunCardView(
                subjectImageUrl: subject.icon,
                subjectName: subject.title,
                numberOfTakers: subject.attemptedCount
            )
            .frame(maxWidth: .infinity)
            .padding()
            .onTapGesture {
                onTapSubject?(subject)
            }
        }
    }
}

#Preview {
    QuizSubjectView(classID: 1)
}
