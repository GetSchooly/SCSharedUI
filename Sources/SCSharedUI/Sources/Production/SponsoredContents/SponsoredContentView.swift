import SwiftUI
import SCComponents
import SCTokens

public struct SponsoredContentView: View {
    
    // variables/properties
    
    // your view model
    @ObservedObject var viewModel: SponsoredContentViewModel = SponsoredContentViewModel()
    
    public init(viewModel: SponsoredContentViewModel) {
        self.viewModel = viewModel
        setupUI()
        initViewModel()
    }
    
    public var body: some View {
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
    
    private func setupUI() {
        // setup for the UI
    }
    
    private func initViewModel() {
        // setup for the ViewModel
        // viewModel.fetchData()
    }
}

#Preview {
    SponsoredContentView(viewModel: SponsoredContentViewModel())
}
