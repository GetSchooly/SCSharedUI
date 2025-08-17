import SwiftUI
import SCTokens
import SCComponents

public struct ViewAllTodayReads: View {
    private var tapOnTodayRead:((_ data: TodayReadModel) -> Void)?
    @StateObject var viewModel: AllTodayReadsViewModel = AllTodayReadsViewModel()

   public init(_ tapOnTodayRead: ((_ data: TodayReadModel) -> Void)? = nil) {
       self.tapOnTodayRead = tapOnTodayRead
    }

    public var body: some View {
        Group{
            switch viewModel.loadingState.viewLoadingState {
            case .idle, .loading:
                readsList
                    .shimmer(isLoading: true)

            case .loaded:
                readsList

            case .failed(let error):
                LoadingViewHelper.errorView(errorMessage: error.localizedDescription) {
                    viewModel.fetchTodayReadList(limit: 10, offset: 0)
                }
            }
        }
        .task {
            viewModel.fetchTodayReadList(limit: 10, offset: 0)
        }
    }

    private var readsList: some View {
        VStack {
            ScrollView(.vertical) {
                ForEach(viewModel.todayReads) { item in
                    BlogCardView(BlogCardViewModel(blog: item))
                        .onTapGesture {
                            tapOnTodayRead?(item)
                        }
                        .padding(.horizontal, Spacing.spacing4x)
                        .padding(.bottom, Spacing.spacing2x)
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    ViewAllTodayReads{data in }
}
