import SwiftUI
import SCTokens
import SCComponents

public struct ThoughtOfTheDayView: View {
    
    // variables/properties
    
    // your view model
    @ObservedObject var viewModel: ThoughtOfTheDayViewModel = ThoughtOfTheDayViewModel()
    
    public init(viewModel: ThoughtOfTheDayViewModel) {
        setupUI()
        self.viewModel = viewModel
        initViewModel()
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: Spacing.spacing2x) {
            SDText("Thought of the day", style: .size100(weight: .semiBold, theme: .primary))
                .frame(height: Sizing.sizing5x)
            thoughtView
        }
        .padding(.horizontal, Spacing.spacing4x)
    }
    
    private var thoughtView: some View {
        VStack(alignment: .leading) {
            SDText("Education is the most powerful weapon you can use to change the world.", style: .size100(weight: .medium, theme: .primary))
            
            VStack{
                SDText("Nelson Mandela", style: .size100(weight: .medium, theme: .primary, alignment: .trailing))
                    .padding(.top, Spacing.spacing1x)
            }.frame(maxWidth: .infinity, alignment: .trailing)
        }
        .frame(maxWidth: .infinity)
        .padding(Spacing.spacing4x)
        .background(Color.lightBlue)
        .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing3x))
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
    ThoughtOfTheDayView(viewModel: ThoughtOfTheDayViewModel())
}
