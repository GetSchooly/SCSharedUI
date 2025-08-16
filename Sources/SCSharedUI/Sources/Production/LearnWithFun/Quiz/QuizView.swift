import SwiftUI
import SCTokens
import SCComponents

struct QuizView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.mainWindowSize) var mainWindowSize
    @Environment(\.navigationManager) var navigationManager
    @StateObject private var viewModel: QuizViewModel = .init()
    @State private var questionIndex = 0
    @State private var submitAnswer: Bool = false
    @State private var resultHeight: CGFloat = 0
    private let quizName: String
    private let quizUniqueId: String

    init(quizName: String, quizUniqueId: String) {
        self.quizName = quizName
        self.quizUniqueId = quizUniqueId
    }

    var body: some View {
        Group {
            switch viewModel.loadingState.viewLoadingState {
            case .idle, .loading:
                quetionView
                    .shimmer(isLoading: true)

            case .loaded:
                quetionView

            case .failed(_):
                EmptyView()
            }
        }
        .task {
            viewModel.fetchQuizQuestions(quizUniqueId: quizUniqueId)
        }
        .toolbar(.hidden, for: .tabBar)
    }

    private var quetionView: some View {
        SCNavigatonView(
            title: "\(quizName) Quiz") {
                dismiss()
            } content: {
                chaptersBottomSheet
            }
    }

    private var chaptersBottomSheet: some View {
        ZStack {
            VStack {
                let question = viewModel.quizQuestions[questionIndex]
                QuizQuestionView(
                    question: question,
                    selectedAnswer: $viewModel.quizQuestions[questionIndex].selectedAnswerIndex,
                    currentQuestionIndex: questionIndex,
                    totalNumberOfQuestions: viewModel.quizQuestions.count) { index in
                        viewModel.setSelectedAnswer(for: questionIndex, answerIndex: index)
                    }

                Button(action: {
                    //submit action
                    submitAnswer.toggle()
                }) {
                    SDText(
                        "Check Answer",
                        style: .size200(
                            weight: .semiBold,
                            theme: .standard,
                            alignment: .center
                        )
                    )
                    .frame(height: Sizing.sizing12x)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: Sizing.sizing3x)
                            .fill(Color.royalBlue)
                    )
                }
                .disabled(question.selectedAnswerIndex == nil)
                .opacity(question.selectedAnswerIndex == nil ? 0.5 : 1)
                .padding(.horizontal, Spacing.spacing6x)
                .padding(.bottom, Spacing.spacing6x)
            }

            resultView
                .frame(maxWidth: .infinity)
                .offset(y: submitAnswer ? 0 : mainWindowSize.height + 20 )
                .animation(.easeInOut, value: submitAnswer)
        }
        .id(questionIndex)
        .transition(
            .asymmetric(
                insertion: .move(edge: .trailing).combined(with: .opacity),
                removal: .move(edge: .leading).combined(with: .opacity)
            )
        )
        .animation(.easeInOut, value: questionIndex)
    }

    private var resultView: some View {
        let question = viewModel.quizQuestions[questionIndex]
        return VStack {
            Spacer()

            ResultView(
                result: viewModel.isAnswerCorrect(for: question)
                    ? .right
                    : .wrong(question.explanation)
            ) {
                if questionIndex < viewModel.quizQuestions.count - 1 {
                    withAnimation {
                        questionIndex += 1
                        submitAnswer.toggle()
                    }
                } else if questionIndex + 1 == viewModel.quizQuestions.count {
                    navigationManager?.homeNavigationPath.append("YourScorePage")
                }
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appwhite.opacity(0.01).ignoresSafeArea())
    }
}

#Preview {
    QuizView(quizName: "Relational Databases", quizUniqueId: "12")
}
