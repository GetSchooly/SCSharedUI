import SwiftUI
import SCTokens
import SCComponents

public struct ViewAllDoActivities: View {
   
    @StateObject var viewModel: DoActivitiesViewModel = DoActivitiesViewModel()
    private var tapOnActivity:((_ data: DoActivitiesModel) -> Void)?
    public init(_ tapOnActivity:((_ data: DoActivitiesModel) -> Void)? = nil) {
        self.tapOnActivity = tapOnActivity
    }
    
    public var body: some View {
        Group{
            switch viewModel.loadingState.viewLoadingState {
            case .idle, .loading:
                activityList
                    .shimmer(isLoading: true)

            case .loaded:
                activityList

            case .failed(let error):
                LoadingViewHelper.errorView(errorMessage: error.localizedDescription) {
                    viewModel.fetchChildrenActivities(limit: 10, offset: 0)
                }
            }
        }
        .task {
            viewModel.fetchChildrenActivities(limit: 10, offset: 0)
        }
    }
    
    private var activityList: some View {
        List(viewModel.activities) { item in
            ActivityCardView(ActivityCardViewModel(activity: item))
                .listRowSeparator(.hidden)
                .onTapGesture {
                    tapOnActivity?(item)
                }
                
        }
        .listStyle(.plain)

    }
}

#Preview {
    ViewAllDoActivities{data in }
}
