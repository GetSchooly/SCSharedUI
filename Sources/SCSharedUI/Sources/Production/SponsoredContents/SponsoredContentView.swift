import SwiftUI
import SCComponents
import SCTokens

public struct SponsoredContentView: View {
    
    // variables/properties
    
    // your view model
    @ObservedObject var viewModel: SponsoredContentViewModel
    
    public init(viewModel: SponsoredContentViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        setupAdUI()
    }
    
    @ViewBuilder
    private func setupAdUI() -> some View {
        switch viewModel.adType {
        case .banner:
            BannerAdView(viewModel: BannerAdViewModel())
        case .interstitial:
            InterstitialAdsView(viewModel: InterstitialAdsViewModel())
        case .flyer:
            EmptyView()
        }
    }
}

#Preview {
    SponsoredContentView(viewModel: SponsoredContentViewModel(adType: .banner))
}
