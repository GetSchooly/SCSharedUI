
import SwiftUI
import SCTokens
import SCComponents

public struct ViewAllTodayReads: View {
   
    @StateObject var viewModel: AllTodayReadsViewModel = AllTodayReadsViewModel()
    
    public init() {
        setupUI()
        initViewModel()
    }
    
    private func setupUI() {
        // setup for the UI
    }
    
    private func initViewModel() {
        // setup for the ViewModel
        // viewModel.fetchData()
    }
    
    public var body: some View {
        VStack {
            readsList
        }
    }
    
    private var readsList: some View {
        List(TodayReadModel.mockToadyReads) { item in
            BlogCardView(BlogCardViewModel(blog: item))
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        
    }
}

#Preview {
    ViewAllTodayReads()
}
