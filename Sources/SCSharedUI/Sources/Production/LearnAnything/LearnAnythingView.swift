import SwiftUI
import SCTokens
import SCComponents

public struct LearnAnythingView: View {
    
    // variables/properties
    
    // your view model
    @ObservedObject var viewModel: LearnAnythingViewModel = LearnAnythingViewModel()
    
    public init(viewModel: LearnAnythingViewModel) {
        setupUI()
        initViewModel()
    }
    
    public var body: some View {
        VStack(spacing: Spacing.spacing2x) {
            HStack {
                SDText("Learn Anything", style: .size100(weight: .semiBold, theme: .primary))
                    .frame(height: Sizing.sizing5x)
                Spacer()
            }
            thoughtView
        }
        .padding(.horizontal, Spacing.spacing4x)
    }
    
    private var aiTutorTitle: some View {
        HStack(spacing: Spacing.spacing1x) {
            SDImage(.local(resource: "", iconSize: .small, contentMode: .fit))
                .background(Color.royalBlue)
            SDText("Edu Buddy", style: .size100(weight: .semiBold, theme: .primary))
            Spacer()
        }
    }
    
    private var thoughtView: some View {
        VStack(alignment: .leading) {
            aiTutorTitle
            
            VStack(alignment: .center) {
                SDText("Nothing here yet", style: .size400(weight: .semiBold, theme: .primary, alignment: .center))
                    .padding(.bottom, Spacing.spacing3x)
                
                SDText("Ask something to Edu Buddy, which you don’t understand ", style: .size300(weight: .medium, theme: .darkGray, alignment: .center))
                    .padding(.bottom, Spacing.spacing4x)
                
                SDButton("Start with AI Tutor", buttonType: .primaryButton(.size200(weight: .semiBold, theme: .standard, alignment: .center)), maxSize: true, onTapAction: {
                    
                })
                .frame(height: Sizing.sizing12x)
            }
        }
        .padding(Spacing.spacing4x)
        .background(Color.white)
        .border(SCBorder(cornerRadius: Sizing.sizing4x, color: .grayStroke.opacity(0.3), width: Sizing.sizing0xQuarter))
        .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing4x))
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
    LearnAnythingView(viewModel: LearnAnythingViewModel())
}
