import SwiftUI
import SCTokens
import SCComponents

struct QuizView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: QuizViewModel = .init()
    @State private var questionIndex = 0
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

            // Bottom navigation
            HStack {
                Button(action: {
                    withAnimation {
                        if questionIndex > 0 {
                            questionIndex -= 1
                        }
                    }
                }) {
                    SDImage(.local(resource: Icons.ic_PreviousArrowWhite.value, iconSize: .medium))
                        .frame(width: Sizing.sizing14x + Sizing.sizing2x, height: Sizing.sizing12x)
                        .background(Capsule().fill(Color.royalBlue))
                }

                Spacer()

                if questionIndex < viewModel.quizQuestions.count - 1 {
                    Button(action: {
                        withAnimation {
                            if questionIndex < viewModel.quizQuestions.count - 1 {
                                questionIndex += 1
                            }
                        }
                    }) {
                        SDImage(.local(resource: Icons.ic_NextArrowWhite.value, iconSize: .medium))
                            .frame(width: Sizing.sizing14x + Sizing.sizing2x, height: Sizing.sizing12x)
                            .background(Capsule().fill(Color.royalBlue))
                    }
                } else {
                    Button(action: {
                        //submit action

                    }) {
                        SDText("Submit", style: .size200(weight: .semiBold, theme: .standard, alignment: .center))
                            .padding(.horizontal, Spacing.spacing4x)
                            .frame(height: Sizing.sizing12x)
                            .background(Capsule().fill(Color.royalBlue))
                    }
                }
            }
            .padding(.horizontal, Spacing.spacing6x)
            .padding(.bottom, Spacing.spacing6x)
        }
    }
}

#Preview {
    QuizView(quizName: "Relational Databases", quizUniqueId: "12")
}
