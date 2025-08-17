import SwiftUI
import SCComponents
import SCTokens

public struct ActivityCardView: View {
    @ObservedObject var viewModel: ActivityCardViewModel
 
    public init(_ viewModel: ActivityCardViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack {
            cardView
                .padding(.top, Spacing.spacing3x)
                .padding(.bottom, Spacing.spacing2x)

            RoundedRectangle(cornerRadius: 1)
                .fill(Color.appBackground)
                .frame(height: 1)
        }
        .background(Color.appwhite)
    }

    private var cardView: some View {
        HStack {
            titleAndSubTitleView
                .layoutPriority(1)
            Spacer()
            SDImage(
                .remote(
                    url: viewModel.imageURL,
                    contentMode: .fill
                )
            )
            .frame(width: Sizing.activityImageWidth, height: Sizing.activityImageHeight)
            .clipped()
        }
        .padding(.horizontal, Spacing.spacing4x)
    }

    private var titleAndSubTitleView: some View {
        VStack(alignment: .leading, spacing: Spacing.spacing1x) {
            SDText(viewModel.title, style: .size90(weight: .semiBold, theme: .darkGray))
                .lineLimit(1)

            SDText(viewModel.subtitle, style: .size90(weight: .regular, theme: .darkGray))
                .lineLimit(2)
        }
        .padding(.trailing, Spacing.spacing2x)
    }
}

private extension Sizing {
    static let activityImageWidth: CGFloat = 90
    static let activityImageHeight: CGFloat = 60
}

#Preview {
    ActivityCardView(ActivityCardViewModel(activity: DoActivitiesModel.mockActivity))
}
