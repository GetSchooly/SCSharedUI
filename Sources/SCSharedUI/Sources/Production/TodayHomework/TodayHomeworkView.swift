import SwiftUI
import SCComponents
import SCTokens

public struct TodayHomeworkView: View {
    
    // your view model
    @ObservedObject var viewModel: TodayHomeworkViewModel = TodayHomeworkViewModel()
    
    public init() {
        setupUI()
        initViewModel()
    }
    
    public var body: some View {
        VStack {
            titleAndFindMoreView
            HomeworkCard()
        }
    }
    
    @ViewBuilder
    private var titleAndFindMoreView: some View {
        HStack(alignment: .center) {
            SDText("Today's Homework", style: .size100(weight: .semiBold, theme: .primary, alignment: .leading))
            Spacer()
            SDButton("View all",
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

#Preview {
    TodayHomeworkView().padding(Spacing.spacing4x)
}
