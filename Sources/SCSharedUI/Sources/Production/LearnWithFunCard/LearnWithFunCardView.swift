import SwiftUI
import SCComponents
import SCTokens

public struct LearnWithFunCardView: View {
    
    // variables/properties
    
    // your view model
    @ObservedObject var viewModel: UpcomingCardViewModel = UpcomingCardViewModel(isShadow: true)
    
    public init() {
        Font.loadMyFonts
        setupUI()
        initViewModel()
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            VStack {
                SDImage(.remote(url: "https://picsum.photos/id/103/600/600", contentMode: .fit))
                    .frame(width: Sizing.sizing12x, height: Sizing.sizing12x)
                    .padding(.bottom, Spacing.spacing3x)
                    .clipped()
            }
            .padding(.horizontal, Sizing.sizing9x)
            .padding(.vertical, Sizing.sizing9x)
            .background(Color.lightBlue)
            
            VStack(alignment: .leading, content: {
                SDText("Science", style: .size90(weight: .bold, theme: .primary))
                    .padding(.bottom, Spacing.spacing1x)
                SDText("212 People taken", style: .size75(weight: .regular, theme: .primary))
            })
            .padding(.top, Spacing.spacing1x)
        }
        .padding(Sizing.sizing4x)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing4x))
        .shadow(SDElevation.defaultGrayElevation)
    }
    
    private func setupUI() {
        // setup for the UI
    }
    
    private func initViewModel() {
        // setup for the ViewModel
        // viewModel.fetchData()
    }
}

private struct Constants {
    static let subjectDateViewHeight: CGFloat = 108
}

extension LearnWithFunCardView: HasExamples {
    static var examples: [Example] {
        [Example("LearnWithFunCardView", width: 300, height: 300) {
            LearnWithFunCardView()
        }]
    }
}

#Preview {
    LearnWithFunCardView()
        .frame(width: 161, height: 183)
}

