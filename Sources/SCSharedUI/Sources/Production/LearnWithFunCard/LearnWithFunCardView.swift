import SwiftUI
import SCComponents
import SCTokens

public struct LearnWithFunCardView: View {
    private let subjectImageUrl: String
    private let subjectName: String
    private let numberOfTakers: Int

    public init(
        subjectImageUrl: String,
        subjectName: String,
        numberOfTakers: Int
    ) {
        self.subjectImageUrl = subjectImageUrl
        self.subjectName = subjectName
        self.numberOfTakers = numberOfTakers
    }

    public var body: some View {
        VStack(alignment: .leading) {
            VStack {
                SDImage(.remote(url: subjectImageUrl, contentMode: .fit))
                    .frame(width: Sizing.sizing12x, height: Sizing.sizing12x)
                    .padding(.bottom, Spacing.spacing3x)
                    .clipped()
            }
            .padding(.horizontal, Sizing.sizing9x)
            .padding(.vertical, Sizing.sizing9x)
            .background(Color.lightBlue)

            VStack(
                alignment: .leading,
                content: {
                    SDText(
                        subjectName,
                        style: .size90(
                            weight: .bold,
                            theme: .primary
                        )
                    )
                    .padding(.bottom, Spacing.spacing1x)

                    SDText(
                        "\(numberOfTakers) People taken",
                        style: .size75(
                            weight: .regular,
                            theme: .primary
                        )
                    )
                }
            )
            .padding(.top, Spacing.spacing1x)
        }
        .padding(Sizing.sizing4x)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing4x))
        .shadow(SDElevation.defaultGrayElevation)
    }
}

private struct Constants {
    static let subjectDateViewHeight: CGFloat = 108
}

extension LearnWithFunCardView: HasExamples {
    static var examples: [Example] {
        [Example("LearnWithFunCardView", width: 300, height: 300) {
            LearnWithFunCardView(
                subjectImageUrl: QuizSubjectModel.mockSubject.icon,
                subjectName: QuizSubjectModel.mockSubject.title,
                numberOfTakers: QuizSubjectModel.mockSubject.attemptedCount
            )
        }]
    }
}

#Preview {
    LearnWithFunCardView(
        subjectImageUrl: QuizSubjectModel.mockSubject.icon,
        subjectName: QuizSubjectModel.mockSubject.title,
        numberOfTakers: QuizSubjectModel.mockSubject.attemptedCount
    )
    .frame(width: 161, height: 183)
}

