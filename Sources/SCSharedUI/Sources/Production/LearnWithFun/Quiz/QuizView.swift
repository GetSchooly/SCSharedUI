import SwiftUI
import SCTokens
import SCComponents

struct QuizView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: QuizViewModel = .init()
    @State private var questionIndex = 0
    @State private var submitAnswer: Bool = false
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
                    .id(questionIndex)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.7), value: questionIndex)

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

            if submitAnswer {
                resultView
                    .transition(.asymmetric(
                        insertion: .move(edge: .bottom).combined(with: .opacity),
                        removal: .move(edge: .bottom).combined(with: .opacity)
                    ))
            }
        }
    }

    private var resultView: some View {
        let question = viewModel.quizQuestions[questionIndex]
        return ResultView(
            result: viewModel.isAnswerCorrect(
                for: question) ? .right : .wrong(question.explanation)
        ) {
            if questionIndex < viewModel.quizQuestions.count - 1 {
                withAnimation {
                    if questionIndex < viewModel.quizQuestions.count - 1 {
                        questionIndex += 1
                    }
                    submitAnswer.toggle()
                }
            }
        }
    }
}

#Preview {
    QuizView(quizName: "Relational Databases", quizUniqueId: "12")
}
