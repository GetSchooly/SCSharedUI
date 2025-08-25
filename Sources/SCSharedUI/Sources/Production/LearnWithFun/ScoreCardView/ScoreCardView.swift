import SwiftUI
import SCComponents
import SCTokens

struct ScoreCardView: View {
    private let gained: Int
    private let total: Int
    private let timeTaken: TimeInterval
    @Environment(\.navigationManager) var navigationManager
    @StateObject private var viewModel: ScoreCardViewModel

    init(gained: Int, total: Int, timeTaken: TimeInterval) {
        self.total = total
        self.gained = gained
        self.timeTaken = timeTaken
        _viewModel = StateObject(wrappedValue: .init(gained: gained, total: total))
    }

    var body: some View {
        allComponent
            .navigationBarHidden(true)
            .onAppear {
                viewModel.showScoreCards.toggle()
            }
    }

    var allComponent: some View {
        VStack {
            mainScorCard
            actionbutton
        }
    }

    private var mainScorCard: some View {
        VStack {
            scoreView
            welcomeText

            Spacer()

            scoreCard
                .padding(.bottom, Spacing.spacing12x)
        }
        .background(content: {
            RoundedRectangle(cornerRadius: Sizing.sizing5x)
                .fill(Color.appwhite)
        })
        .shareSheet(
            items: [
                viewModel.scoreCardImage ?? UIImage(),
                viewModel.shareResultMessage(gained: gained, total: total)
            ],
            isPresented: $viewModel.isShareSheetPresented
        )
    }
    
    var scoreView: some View {
        ZStack {
            Circle()
                .fill(Color.royalBlue)
                .shadow(.defaultGrayElevation)

            Circle()
                .stroke(lineWidth: Sizing.sizing3x)
                .foregroundColor(Color.appwhite.opacity(0.9))
                .padding(Spacing.spacing2x)
            
            VStack(spacing: Spacing.spacing2x) {
                SDText(
                    "Your Score",
                    style: .size500(
                        weight: .medium,
                        theme: .standard,
                        alignment: .center
                    )
                )

                SDText(
                    "\(gained)/\(total)",
                    style: .size600(
                        weight: .bold,
                        theme: .standard,
                        alignment: .center
                    )
                )
            }
            .foregroundColor(.appwhite)
        }
        .frame(width: 250, height: 250)
        .padding(.top, Spacing.spacing10x)
    }

    private var welcomeText: some View {
        VStack(spacing: Spacing.spacing1x) {
            SDText(
                viewModel.feedback?.title ?? "",
                style: .size400(
                    weight: .semiBold,
                    theme: .royalBlue,
                    alignment: .center
                )
            )

            SDText(
                viewModel.feedback?.message ?? "",
                style: .size200(
                    weight: .medium,
                    theme: .darkGray,
                    alignment: .center
                )
            )
        }
        .padding(Spacing.spacing5x)
    }

    private var scoreCard: some View {
        Group {
            HStack(spacing: Spacing.spacing4x) {
                SDScoreCard(
                    title: "Total Points",
                    subTitle: "\(gained)",
                    foregroundColor: .standard,
                    backgroundColor: .bright
                )
                .opacity(viewModel.showScoreCards ? 1 : 0)
                .animation(.easeIn(duration: 1).delay(0), value: viewModel.showScoreCards)
 
                SDScoreCard(
                    title: "Score",
                    subTitle: "\(viewModel.scorePercentage(gained: gained, total: total))%",
                    foregroundColor: .standard,
                    backgroundColor: .royalBlue
                )
                .opacity(viewModel.showScoreCards ? 1 : 0)
                .animation(.easeIn(duration: 1).delay(1), value: viewModel.showScoreCards)

                SDScoreCard(
                    title: "Timing",
                    subTitle: "\(viewModel.getTimeTakenInMinutes(timeTaken))",
                    foregroundColor: .standard,
                    backgroundColor: .positive
                )
                .opacity(viewModel.showScoreCards ? 1 : 0)
                .animation(.easeIn(duration: 1).delay(2), value: viewModel.showScoreCards)
            }
        }
        .frame(height: Sizing.sizing5x * Sizing.sizing1x)
        .padding(.horizontal, Spacing.spacing5x)
    }

    private var actionbutton: some View {
        Group {
            HStack(spacing: Spacing.spacing4x){
                SDButton(
                    "Collect Points",
                    buttonType:
                            .primaryButton(
                                .size200(
                                    weight: .medium,
                                    theme: .standard,
                                    alignment: .center
                                )
                            ),
                    maxSize: true
                ) {
                    navigationManager?.homeNavigationPath.popToRoot()
                }
                .frame(height: Sizing.sizing12x)

                SDButton(
                    "Share",
                    buttonType:
                            .plain(
                                .size200(
                                    weight: .medium,
                                    theme: .standard,
                                    alignment: .center
                                )
                            ),
                    maxSize: true
                ) {
                    viewModel.scoreCardImage = mainScorCard.snapshot()
                    viewModel.isShareSheetPresented.toggle()
                }
                .frame(width: Sizing.sizing2x * Sizing.sizing2xHalf)
            }
        }
        .frame(height: Sizing.sizing12x)
        .padding(.bottom, Spacing.spacing10x * 2)
        .padding(.horizontal, Spacing.spacing6x)
    }
}

#Preview {
    ScoreCardView(gained: 12, total: 15, timeTaken: 45)
        .padding()
}
