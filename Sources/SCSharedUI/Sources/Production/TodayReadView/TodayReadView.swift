import SwiftUI
import SCComponents
import SCTokens

public struct TodayReadView: View {
    
    // variables/properties
    
    // your view model
    @ObservedObject var viewModel: TodayReadViewModel = TodayReadViewModel()
    
    public init() {
        setupUI()
        initViewModel()
    }
    
    public var body: some View {
        VStack {
            titleAndFindMoreView
            BlogCardList()
        }
        .padding(.leading, Spacing.spacing4x)
        .background(Color.clear)
    }
    
    @ViewBuilder
    private var titleAndFindMoreView: some View {
        HStack(alignment: .center) {
            SDText("Today's read", style: .size100(weight: .semiBold, theme: .primary, alignment: .leading))
            Spacer()
            SDButton("See all",
                     buttonType: .noStyle(.size90(weight: .bold, theme: .royalBlue, alignment: .trailing))) {
                
            }
        }
        .frame(height: Spacing.spacing5x)
    }
    
    private func setupUI() {
        // setup for the UI
    }
    
    private func initViewModel() {
        // setup for the ViewModel
        // viewModel.fetchData()
    }
}

private struct BlogCardList: View {
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: Spacing.spacing4x) {
                ForEach(0..<3) { item in
                    BlogCardView()
                        .frame(width: UIScreen.main.bounds.size.width - 80)
                }
            }
        }
        .scrollIndicators(.never)
    }
}

#Preview {
    TodayReadView()
}
