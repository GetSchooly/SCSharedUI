import SwiftUI
import SCComponents
import SCTokens

public struct DoActivitiesView: View {
    
    // variables/properties
    
    // your view model
    @StateObject var viewModel: DoActivitiesViewModel = DoActivitiesViewModel()
    private let tapOnSeeAll:(() -> Void)
    
    public init(tapOnSeeAll: @escaping (() -> Void)) {
        self.tapOnSeeAll = tapOnSeeAll
        setupUI()
        initViewModel()
    }
    
    public var body: some View {
        VStack {
            titleAndFindMoreView
            ActivitiesList()
        }
        .padding(.horizontal, Spacing.spacing4x)
        .background(Color.clear)
    }
    
    @ViewBuilder
    private var titleAndFindMoreView: some View {
        HStack(alignment: .center) {
            SDText("Do activities with your children", style: .size100(weight: .semiBold, theme: .primary, alignment: .leading))
            Spacer()
            SDButton("All activities",
                     buttonType: .noStyle(.size90(weight: .bold, theme: .royalBlue, alignment: .trailing))) {
                tapOnSeeAll()
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

private struct ActivitiesList: View {
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<3) { item in
                ActivityCardView(ActivityCardViewModel())
            }
        }
    }
}

#Preview {
    DoActivitiesView{}
}
