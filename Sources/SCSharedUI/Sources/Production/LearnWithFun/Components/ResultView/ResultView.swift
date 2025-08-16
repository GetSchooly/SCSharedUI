import SwiftUI
import SCTokens
import SCComponents

enum QuizResult {
    case right
    case wrong(String)
}

struct ResultView: View {
    private let result: QuizResult
    private let onNext: () -> Void

    init(result: QuizResult, onNext: @escaping () -> Void) {
        self.result = result
        self.onNext = onNext
    }

    var body: some View {
        switch result {
        case .right:
            VStack {
                Spacer()
                VStack {
                    VStack {
                        titleView(ResultExpression.rightAnswer.randomElement() ?? "", textTheme: .positive)
                            .padding(.vertical, Spacing.spacing2x)

                        SDText(
                            "Continue",
                            style: .size300(
                                weight: .semiBold,
                                theme: .standard,
                                alignment: .center
                            )
                        )
                        .onTapGesture {
                            onNext()
                        }
                        .padding(Spacing.spacing4x)
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .frame(height: Sizing.sizing12x)
                        .cornerRadius(Sizing.sizing3x)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(alignment: .leading)
                    .padding(Spacing.spacing4x)
                    .padding(.bottom, Spacing.spacing12x)
                    .background(Color.green.opacity(0.1))
                }
                .background(Color.appwhite)
                .shadow(.defaultGrayElevation)
            }
            .background(Color.clear)

        case .wrong(let rightAnswer):
            VStack {
                Spacer()
                VStack {
                    VStack(spacing: Spacing.spacing2x) {
                        titleView(ResultExpression.wrongAnswer.randomElement() ?? "", textTheme: .negative)
                            .padding(.top, Spacing.spacing2x)

                        answerView(rightAnswer)

                        SDText(
                            "Keep going",
                            style: .size300(
                                weight: .semiBold,
                                theme: .standard,
                                alignment: .center
                            )
                        )
                        .padding(Spacing.spacing4x)
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .frame(height: Sizing.sizing12x)
                        .cornerRadius(Sizing.sizing3x)
                        .padding(.top, Spacing.spacing2x)
                        .onTapGesture {
                            onNext()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(alignment: .leading)
                    .padding(Spacing.spacing4x)
                    .padding(.bottom, Spacing.spacing10x)
                    .background(Color.red.opacity(0.1))
                }
                .background(Color.appwhite)
                .shadow(.defaultGrayElevation)
            }
            .background(Color.clear)
        }
    }

    private func titleView(_ expression: String, textTheme: SDTextTheme) -> some View {
        HStack {
            SDImage(
                .local(resource: Icons.ic_check.value, iconSize: .medium)
            )
            .padding(Spacing.spacing1xHalf)
            .background(textTheme == .positive ? Color.green : Color.red)
            .clipShape(.circle)

            SDText(
                expression,
                style: .size300(
                    weight: .bold,
                    theme: textTheme,
                    alignment: .leading
                )
            )
            .padding(.horizontal, Spacing.spacing1xHalf)

            Spacer()
        }
    }

    private func answerView(_ answer: String) -> some View {
        HStack(alignment: .top) {
            SDText(
                "Right Answer: ",
                style: .size200(
                    weight: .medium,
                    theme: .negative,
                    alignment: .leading
                )
            )

            SDText(
                answer,
                style: .size200(
                    weight: .regular,
                    theme: .negative,
                    alignment: .leading
                )
            )

            Spacer()
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        

        ResultView(result: .wrong("This is the right answer.")) {

        }
    
        ResultView(result: .right) {

        }
    }
}
