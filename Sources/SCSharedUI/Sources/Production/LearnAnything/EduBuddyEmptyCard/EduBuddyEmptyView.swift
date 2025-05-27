import SwiftUI
import SCTokens
import SCComponents

public struct EduBuddyEmptyView: View {
    
    // variables/properties
    private var onTap: (() -> Void)?
    
    // your view model
    @ObservedObject var viewModel: EduBuddyEmptyViewModel = EduBuddyEmptyViewModel()
    
    public init(viewModel: EduBuddyEmptyViewModel, onTap: (() -> Void)? = nil) {
        self.onTap = onTap
        setupUI()
        initViewModel()
        Font.loadMyFonts
    }
    
    public var body: some View {
        VStack(spacing: Spacing.spacing2x) {
            HStack {
                SDText("Learn Anything", style: .size300(weight: .semiBold, theme: .primary))
                    .frame(height: Sizing.sizing5x)
                Spacer()
            }
            descriptionView
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
    
    private var descriptionView: some View {
        VStack(alignment: .leading) {
            aiTutorTitle
            
            SDText("I’ll help you understand anything!", style: .size200(weight: .regular, theme: .darkGray, alignment: .center))
                .padding(.bottom, Spacing.spacing3x)
            
            SDText("Type an exam question, a homework problem or anything you don’t understand.", style: .size200(weight: .regular, theme: .darkGray, alignment: .leading))
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
    EduBuddyEmptyView(viewModel: EduBuddyEmptyViewModel())
}
