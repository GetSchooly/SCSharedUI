import SwiftUI
import SCComponents
import SCTokens

struct BannerAdView: View {
    
    // variables/properties
    
    // your view model
    @ObservedObject var viewModel: BannerAdViewModel
    
    init(viewModel: BannerAdViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
            SDImage(.remote(url: "https://picsum.photos/id/3/400/200", contentMode: .fill))
                .frame(height: Sizing.sizing5x * Sizing.sizing2x)
                .clipShape(.rect(cornerRadius: Sizing.sizing4x))
            SDButton("Ad", buttonType: .ad()) {}
                .padding(.trailing, Spacing.spacing2x)
                .padding(.top, Spacing.spacing2x)
        })
        .padding(.horizontal, Spacing.spacing4x)
        .padding(.top, Spacing.spacing2x)
    }
}

#Preview {
    BannerAdView(viewModel: BannerAdViewModel())
}
