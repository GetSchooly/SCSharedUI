import SwiftUI
import SCTokens
import SCComponents

public enum QuizSubjectLayout {
    case home
    case detail(subjects: [QuizSubjectModel] = [])
}

public struct QuizSubjectView: View {
    @StateObject private var viewModel: QuizSubjectsViewModel = QuizSubjectsViewModel()
    @State private var showQuizView: Bool = false
    @Environment(\.navigationManager) private var navigationManager

    private let columns = [
        GridItem(.flexible(), spacing: Spacing.spacing1x),
        GridItem(.flexible(), spacing: Spacing.spacing1x)
    ]
    private let classID: Int
    private let pageLayout: QuizSubjectLayout
    private let onTapSeeAll:(([QuizSubjectModel]) -> Void)?

    public init(
        classID: Int,
        pageLayout: QuizSubjectLayout = .home,
        onTapSubject: ((QuizSubjectModel) -> Void)? = nil,
        onTapSeeAll: (([QuizSubjectModel]) -> Void)? = nil
    ) {
        self.classID = classID
        self.pageLayout = pageLayout
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
        .sheet(item: $viewModel.selectedSubject) { subject in
            QuizChapterListView(
                uniqueID: subject.uniqueID,
                subjectName: subject.title) { index, chapter in
                    viewModel.selectedChapter(chapter)
                    viewModel.selectedSubject = nil
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                        self.navigationManager?.homeNavigationPath.append("quizView")
                    })
                }
        }
        .navigationDestination(for: String.self) { value in
            if value == "quizView", let selectedQuizId = viewModel.selectedQuizId {
                QuizView(
                    quizName: viewModel.selectedSubject?.title ?? "" ,
                    quizUniqueId: selectedQuizId,
                    gainedScore: $viewModel.gaindeScore,
                    totalScore: $viewModel.totalScore,
                    timeTaken: $viewModel.timeTaken
                )
            } else if value == "YourScorePage" {
                // Push to score view
                ScoreCardView(
                    gained: viewModel.gaindeScore,
                    total: viewModel.totalScore,
                    timeTaken: viewModel.timeTaken
                )
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
                LearnWithFunHomeView(
                    viewModel: viewModel,
                    onTapSubject: { subject in
                        viewModel.selectedSubject(subject)
                    }, onTapSeeAll:  {
                        onTapSeeAll?(viewModel.quizSubjects)
                    }
                )

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
            LazyVGrid(columns: columns, spacing: Spacing.spacing1x) {
                subjectView
            }
            .padding(.horizontal, Spacing.spacing1x)
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
                viewModel.selectedSubject(subject)
            }
        }
    }
}

#Preview {
    QuizSubjectView(classID: 1)
}

