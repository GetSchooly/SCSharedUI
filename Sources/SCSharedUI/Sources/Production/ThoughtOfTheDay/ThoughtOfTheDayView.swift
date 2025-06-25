import SwiftUI
import SCTokens
import SCComponents

public struct ThoughtOfTheDayView: View {

    // your view model
    @StateObject var viewModel: ThoughtOfTheDayViewModel = ThoughtOfTheDayViewModel()
    @State private var refreshID: UUID = UUID()
    
    public init() { }
    
    public var body: some View {
        LoadableView(refreshTrigger: refreshID,
                     viewModel: viewModel,
                     publisher: { viewModel.fetchThoughtOfTheDay() })
        {
            Group {
                switch viewModel.loadingState.viewLoadingState {
                case .idle, .loading:
                    mainContentView
                        .shimmer(isLoading: true)
                    
                case .loaded:
                    mainContentView
                    
                case .failed(let error):
                    // refreshID = UUID()
                    EmptyView()
                }
            }
        }
    }

    private var mainContentView: some View {
        VStack(alignment: .leading, spacing: Spacing.spacing2x) {
            SDText("Thought of the day", style: .size100(weight: .semiBold, theme: .primary))
                .frame(height: Sizing.sizing5x)
            thoughtView
        }
        .padding(.horizontal, Spacing.spacing4x)
    }
    
    private var thoughtView: some View {
        VStack(alignment: .leading) {
            SDText(viewModel.thoughtOfTheDay.thought, style: .size100(weight: .medium, theme: .primary))
            
            VStack{
                SDText(viewModel.thoughtOfTheDay.writtenBy, style: .size100(weight: .medium, theme: .primary, alignment: .trailing))
                    .padding(.top, Spacing.spacing1x)
            }.frame(maxWidth: .infinity, alignment: .trailing)
        }
        .frame(maxWidth: .infinity)
        .padding(Spacing.spacing4x)
        .background(Color.lightBlue)
        .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing4x))
    }
}

#Preview {
    ThoughtOfTheDayView()
}
