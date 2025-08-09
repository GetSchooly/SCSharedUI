import SwiftUI
import SCComponents
import SCTokens

public struct TodayReadView: View {
    
    // variables/properties
    
    // your view model
    @ObservedObject var viewModel: TodayReadViewModel = TodayReadViewModel()
    private let tapOnSeeAll:(() -> Void)
    
    public init(tapOnSeeAll: @escaping (() -> Void)) {
        self.tapOnSeeAll = tapOnSeeAll
    }
    
    public var body: some View {
        VStack {
            titleAndFindMoreView
            BlogCardList(todayReadData: viewModel.todayReads)
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
        }
        .frame(height: Spacing.spacing5x)
    }

}

private struct BlogCardList: View {
    let todayReadData: [TodayReadModel]
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: Spacing.spacing4x) {
                ForEach(todayReadData.prefix(5)) { item in
                    BlogCardView(BlogCardViewModel(blog: item))
                        .frame(width: UIScreen.main.bounds.size.width - 80)
                }
            }
        }
        .scrollIndicators(.never)
    }
}

#Preview {
    TodayReadView{}
}
