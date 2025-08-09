import SwiftUI
import SCComponents
import SCTokens

public struct DoActivitiesView: View {
    // variables/properties
    // your view model
    @StateObject var viewModel: DoActivitiesViewModel = DoActivitiesViewModel()
    @State private var refreshId = UUID()
    private var tapOnSeeAll:(() -> Void)?
    
    public init(tapOnSeeAll: (() -> Void)? = nil) {
        self.tapOnSeeAll = tapOnSeeAll
    }
    
    public var body: some View {
        Group{
            switch viewModel.loadingState.viewLoadingState {
            case .idle, .loading:
                mainContentView
                    .shimmer(isLoading: true)
                
            case .loaded:
                mainContentView
                
            case .failed(let error):
                LoadingViewHelper.errorView(errorMessage: error.localizedDescription) {
                    refreshId = UUID()
                }
            }
        }
        .task {
            viewModel.fetchChildrenActivities(limit: 10, offset: 0)
        }
    }
    
    private var mainContentView: some View {
        VStack {
            titleAndFindMoreView
            activityList
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
                tapOnSeeAll?()
            }
        }
        .frame(height: Spacing.spacing5x)
    }
    
    private var activityList: some View {
        VStack(spacing: 0) {
            ForEach(viewModel.activities.prefix(3)) { item in
                ActivityCardView(ActivityCardViewModel(activity: item))
            }
        }
    }
}

#Preview {
    DoActivitiesView{}
}
