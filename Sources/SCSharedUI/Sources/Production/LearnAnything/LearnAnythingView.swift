import SwiftUI
import SCTokens
import SCComponents

public struct LearnAnythingView: View {
    private let userId: String
    private let onTap: (() -> Void)?
    @StateObject private var viewModel: LearnAnythingViewModel = .init()

    public init(userId: String, onTap: (() -> Void)? = nil) {
        self.userId = userId
        self.onTap = onTap
    }

    public var body: some View {
        Group {
            switch viewModel.loadingState.viewLoadingState {
            case .idle, .loading:
                noSessionContentView
                    .shimmer(isLoading: true)
                
            case .loaded:
                eduBuddySessionsView
                    .padding(.horizontal, Spacing.spacing4x)

            case .failed(let error):
                LoadingViewHelper.errorView(errorMessage: error.localizedDescription) {
                    viewModel.fetchAllRecentSessionByUserId(userId)
                }
            }
        }
        .task {
            viewModel.fetchAllRecentSessionByUserId(userId)
        }
    }

    private var noSessionContentView: some View {
        VStack(spacing: Spacing.spacing2x) {
            HStack {
                SDText(
                    "Learn Anything",
                    style: .size100(
                        weight: .semiBold,
                        theme: .primary
                    )
                )
                .frame(height: Sizing.sizing5x)

                Spacer()
            }
            thoughtView
        }
        .padding(.horizontal, Spacing.spacing4x)
    }

    private var aiTutorTitle: some View {
        HStack(spacing: Spacing.spacing1x) {
            SDImage(
                .local(
                    resource: "",
                    iconSize: .small,
                    contentMode: .fit
                )
            )
            .background(Color.royalBlue)

            SDText(
                "Edu Buddy",
                style: .size100(
                    weight: .semiBold,
                    theme: .primary
                )
            )

            Spacer()
        }
    }

    private var thoughtView: some View {
        VStack(alignment: .leading) {
            aiTutorTitle

            VStack(alignment: .center) {
                SDText(
                    "Nothing here yet",
                    style: .size400(
                        weight: .semiBold,
                        theme: .primary,
                        alignment: .center
                    )
                )
                .padding(.bottom, Spacing.spacing3x)

                SDText(
                    "Ask something to Edu Buddy, which you don’t understand ",
                    style: .size300(
                        weight: .medium,
                        theme: .darkGray,
                        alignment: .center
                    )
                )
                .padding(.bottom, Spacing.spacing4x)

                SDButton(
                    "Start with AI Tutor",
                    buttonType: .primaryButton(
                        .size200(
                            weight: .semiBold,
                            theme: .standard,
                            alignment: .center
                        )
                    ),
                    maxSize: true,
                    onTapAction: {
                        onTap?()
                    }
                )
                .frame(height: Sizing.sizing12x)
            }
        }
        .padding(Spacing.spacing4x)
        .background(Color.white)
        .border(SCBorder(cornerRadius: Sizing.sizing4x, color: .grayStroke.opacity(0.3), width: Sizing.sizing0xQuarter))
        .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing4x))
    }
}

extension LearnAnythingView {
    private var eduBuddySessionsView: some View {
        VStack(alignment: .leading) {
            sessionViewTitle
                .padding(.top, Spacing.spacing4x)
                .padding(.horizontal, Spacing.spacing4x)

            Divider()
                .foregroundStyle(Color.lightBlue)
                .padding(.vertical, Spacing.spacing1x)

            ForEach(viewModel.recentSessions, id: \.id) { item in
                HStack {
                    SDText(
                        item.question,
                        style: .size90(
                            weight: .regular,
                            theme: .primary,
                            alignment: .leading
                        )
                    )
                    .lineLimit(1)

                    Spacer()

                    SDImage(
                        .local(
                            resource: Icons.ic_NextArrow.value,
                            iconSize: .small,
                            contentMode: .fit,
                        )
                    )
                }

                if item != viewModel.recentSessions.last {
                    Divider()
                        .foregroundStyle(Color.appBackground)
                } else {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: Sizing.sizing2x)
                }
            }
            .padding(.horizontal, Spacing.spacing4x)
        }
        .background(Color.appwhite)
        .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing5x))
        .shadow(.defaultGrayElevation)
    }

    private var sessionViewTitle: some View {
        HStack(alignment: .center) {
            aiTutorTitle

            SDButton(
                "Start New",
                buttonType: .primaryButton(
                    .size100(
                        weight: .semiBold,
                        theme: .standard,
                        alignment: .center
                    )
                ),
                maxSize: true,
                onTapAction: {
                    onTap?()
                }
            )
            .frame(width: Sizing.sizing12x * Sizing.sizing0xHalf, height: Sizing.sizing8x)
            .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing5x))
        }
    }
}

#Preview {
    LearnAnythingView(userId: "")
        .padding()
}
