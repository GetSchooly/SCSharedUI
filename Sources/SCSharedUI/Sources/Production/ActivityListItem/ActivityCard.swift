import SwiftUI
import SCComponents
import SCTokens

public struct ActivityCardView: View {
    
    // variables/properties
    
    // your view model
    @ObservedObject var viewModel: ActivityCardViewModel
    
    public init(_ viewModel: ActivityCardViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            cardView
            RoundedRectangle(cornerRadius: 1)
                .fill(Color.appBackground)
                .frame(height: 1)
        }
        .background(Color.white)
    }
    
    private var cardView: some View {
        HStack(alignment:.top) {
            titleAndSubTitleView
            Spacer()
            SDImage(.remote(url: viewModel.imageURL))
                .frame(width: Sizing.activityImageWidth, height: Sizing.activityImageHeight)
        }
        .padding(Spacing.spacing4x)
    }
    
    private var titleAndSubTitleView: some View {
        VStack(alignment: .leading) {
            SDText(viewModel.title, style: .size90(weight: .semiBold, theme: .darkGray))
                .padding(.bottom, Spacing.spacing0xQuarter)
            
            SDText(viewModel.subtitle, style: .size90(weight: .regular, theme: .darkGray))
        }
        .padding(.trailing, Spacing.spacing2x)
    }
}

private extension Sizing {
    static let activityImageWidth: CGFloat = 90
    static let activityImageHeight: CGFloat = 60
}

#Preview {
    ActivityCardView(ActivityCardViewModel(activity: Activities.mockActivity))
}
