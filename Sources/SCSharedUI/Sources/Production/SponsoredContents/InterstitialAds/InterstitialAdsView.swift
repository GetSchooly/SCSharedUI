import SwiftUI
import SCComponents
import SCTokens

struct InterstitialAdsView: View {
    
    // variables/properties
    
    // your view model
    @ObservedObject var viewModel: InterstitialAdsViewModel
    
    init(viewModel: InterstitialAdsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
                    VStack {
                        SDImage(.remote(url: "https://fastly.picsum.photos/id/20/3670/2462.jpg?hmac=CmQ0ln-k5ZqkdtLvVO23LjVAEabZQx2wOaT4pyeG10I", contentMode: .fill))
                    }
                    .frame(width: 320, height: 300)
                    .padding(.horizontal, Spacing.spacing4x)
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
                    .lineLimit(3)
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
                .frame(height: Sizing.sizing12x)
                .padding(.top, Spacing.spacing12x)
                .padding(.horizontal, Spacing.spacing4x)
            }
            Spacer()
            ProgressBarView()
                .padding(.horizontal, Spacing.spacing0x)
                .padding(.bottom, Spacing.spacing0x)
        }
    }
}

private struct ProgressBarView: View {
    @State private var progress: Double = 0.0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        ProgressView(value: progress)
            .progressViewStyle(.linear)
            .tint(Color.royalBlue)
            .frame(height: 4)
            .onReceive(timer) { _ in
                if progress < 1.0 {
                    progress += 0.05
                }
            }
    }
}

#Preview {
    InterstitialAdsView(viewModel: InterstitialAdsViewModel())
}
