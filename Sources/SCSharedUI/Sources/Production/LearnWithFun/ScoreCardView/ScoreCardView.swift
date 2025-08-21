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
    }

    var allComponent: some View {
        VStack(){
            Group{
                scoreView
                welcomeText
            }
            Spacer()
            actionbutton
        }
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
                    theme: .royalBlue,
                    alignment: .center
                )
            )
        }
        .padding(Spacing.spacing4x)
    }

    private var actionbutton: some View {
        Group {
            VStack(spacing: Spacing.spacing5x){
                SDButton(
                    "Share",
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
                    
                }
                .frame(height: Sizing.sizing12x)

                SDButton(
                    "Back to home",
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
            }
        }
        .frame(height: Sizing.sizing12x)
        .padding(.bottom, Spacing.spacing12x * 2)
        .padding(.horizontal, Spacing.spacing6x)
    }
}

#Preview {
    ScoreCardView(gained: 12, total: 15, timeTaken: 45)
        .padding()
}
