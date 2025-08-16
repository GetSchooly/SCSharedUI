import SwiftUI
import SCTokens
import SCComponents

struct QuizQuestionView: View {
    @Binding var selectedAnswer: Int?
    private let currentQuestionIndex: Int
    private let totalNumberOfQuestions: Int
    private let question: QuizModel
    private var onAnswerSelected: (_ index: Int) -> Void = { _ in }
 
    public init(
        question: QuizModel,
        selectedAnswer: Binding<Int?>,
        currentQuestionIndex: Int = 0,
        totalNumberOfQuestions: Int,
        onAnswerSelected: @escaping (_ index: Int) -> Void
    ) {
        self.question = question
        self._selectedAnswer = selectedAnswer
        self.currentQuestionIndex = currentQuestionIndex
        self.totalNumberOfQuestions = totalNumberOfQuestions
        self.onAnswerSelected = onAnswerSelected
        Font.loadMyFonts
    }

    var body: some View {
        VStack {
            HStack {
                SDText(
                    "Question: \(currentQuestionIndex + 1)/\(totalNumberOfQuestions)",
                    style:.size100(
                        weight: .bold,
                        theme: .royalBlue
                    )
                )

                Spacer()

                SDButton(
                    "Quit",
                    buttonType: .noStyle(
                        .size100(
                            weight: .bold,
                            theme: .negative
                        )
                    )
                ) {
                    // Quit action
                }
                .hidden()
            }

            // Question
            SDText(
                question.question,
                style: .size300(
                    weight: .medium,
                    theme: .primary
                )
            )
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, Spacing.spacing4x)
            .padding(.horizontal, Spacing.spacing1x)

            // Answers list
            ScrollView {
                VStack(spacing: Spacing.spacing4x) {
                    ForEach(question.options.indices, id: \.self) { index in
                        Button(action: {
                            selectedAnswer = index
                            onAnswerSelected(index)
                        }) {
                            SDText(
                                question.options[index],
                                style:.size200(
                                    weight: .regular,
                                    theme: selectedAnswer == index ? .standard : .primary
                                )
                            )
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: Sizing.sizing3x)
                                    .fill(selectedAnswer == index ? Color.royalBlue : Color.white)
                                    .shadow(.defaultGrayElevation)
                            )
                        }
                    }
                }
                .padding(.top, Spacing.spacing12x)
                .padding(.horizontal, Spacing.spacing2x)
            }

            Spacer()
        }
        .padding(.bottom, Spacing.spacing4x)
        .padding(.horizontal, Spacing.spacing4x)
    }
}

#Preview {
    @State var selectedIndex: Int? = nil
    
    QuizQuestionView(
        question: QuizModel(
            id: 2,
            quizUniqueID: "quizUniqueID",
            question: "limit of sin(x)/x as x approaches 1?",
            options: [
                "0.5",
                "0",
                "1",
                "None of them above"
            ],
            correctOption: 1,
            answer: "1",
            explanation: "lim(x→0) sin(x)/x = 1.",
            questionType: .mcq,
            difficulty: .easy,
            imageURL: nil,
            board: "CBSE"
        ), selectedAnswer: $selectedIndex,
        totalNumberOfQuestions: 20) { index in

        }
}
