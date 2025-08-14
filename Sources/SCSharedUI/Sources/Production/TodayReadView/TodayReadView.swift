import SwiftUI
import SCComponents
import SCTokens

public struct TodayReadView: View {
    
    // variables/properties
    
    // your view model
    @ObservedObject var viewModel: TodayReadViewModel = TodayReadViewModel()
    private let tapOnSeeAll:(() -> Void)
    private var tapOnTodayRead:((_ data: TodayReadModel) -> Void)?
    
    public init(tapOnSeeAll: @escaping (() -> Void), tapOnTodayRead: ((_ data: TodayReadModel) -> Void)? = nil) {
        self.tapOnSeeAll = tapOnSeeAll
        self.tapOnTodayRead = tapOnTodayRead
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
                    viewModel.fetchTodayReadList(limit: 10, offset: 0)
                }
            }
        }
        .task {
            viewModel.fetchTodayReadList(limit: 10, offset: 0)
        }
    }
    
    private var mainContentView: some View {
        VStack {
            titleAndFindMoreView
            BlogCardList(todayReadData: viewModel.todayReads){ data in
                self.tapOnTodayRead?(data)
            }
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
                self.tapOnSeeAll()
            }
            .padding(20)
        }
        .frame(height: Spacing.spacing5x)
    }

}

private struct BlogCardList: View {
    let todayReadData: [TodayReadModel]
    private var tapOnBlog:((_ data: TodayReadModel) -> Void)?
    init(todayReadData: [TodayReadModel], tapOnBlog: ((_: TodayReadModel) -> Void)? = nil) {
        self.todayReadData = todayReadData
        self.tapOnBlog = tapOnBlog
    }
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: Spacing.spacing4x) {
                ForEach(todayReadData.prefix(5)) { item in
                    BlogCardView(BlogCardViewModel(blog: item))
                        .frame(width: UIScreen.main.bounds.size.width - 80)
                        .onTapGesture {
                            tapOnBlog?(item)
                        }
                }
            }
        }
        .scrollIndicators(.never)
    }
}

#Preview {
    TodayReadView{}
}
