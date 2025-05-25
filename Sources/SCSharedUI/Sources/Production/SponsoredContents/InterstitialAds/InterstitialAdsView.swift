import SwiftUI
import SCComponents
import SCTokens

struct InterstitialAdsView: View {
    
    // variables/properties
    
    // your view model
    @StateObject var viewModel: InterstitialAdsViewModel = InterstitialAdsViewModel()
    
    init() {
        setupUI()
        initViewModel()
        Font.loadMyFonts
    }
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
            SDImage(.remote(url: "https://fastly.picsum.photos/id/20/3670/2462.jpg?hmac=CmQ0ln-k5ZqkdtLvVO23LjVAEabZQx2wOaT4pyeG10I", contentMode: .fill))
                .frame(width: 350, height: 300)
                .clipShape(.rect(cornerRadius: Sizing.sizing4x))
            SDButton("Ad", buttonType: .ad()) {}
                .padding(.trailing, Spacing.spacing3x)
                .padding(.top, Spacing.spacing3x)
        })
        .padding(.top, Spacing.spacing4x)
        
        VStack(alignment: .leading, spacing: Spacing.spacing0x) {
            SDText("Free Admission for 100 Students.",
                   style: .size400(weight: .semiBold, theme: .primary, alignment: .leading),
                   decoration: .none)
            SDText("Enroll now and secure your child’s future at zero cost. Limited seats — offer valid for the first 100 students only!",
                   style: .size200(weight: .regular, theme: .primary, alignment: .leading),
                   decoration: .none)
        }
        .padding(.top, Spacing.spacing4x)
        .padding(.horizontal, Spacing.spacing4x)
        
        SDButton("Click here to enroll",
                 buttonType: .primaryButton(.size200(weight: .medium,
                                                     theme: .standard,
                                                     alignment: .center)),
                 maxSize: true)
        {
            
        }
        .frame(height: 50)
        .padding(.top, Spacing.spacing12x)
        .padding(.horizontal, Spacing.spacing4x)
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
    InterstitialAdsView()
}
