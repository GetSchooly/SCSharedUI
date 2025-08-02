
import SwiftUI
import SCTokens
import SCComponents

public struct ViewAllQuizList: View {
   
    @StateObject var viewModel: AllQuizListViewModel = AllQuizListViewModel()

    let columns = [ GridItem(.flexible() , spacing: 5) , GridItem(.flexible() , spacing: 5)]
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
        quizList
    }
    
    private var quizList: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                
                ForEach(viewModel.allTodayReads, id: \.self) { item in
                    
                    LearnWithFunCardView()
                        .padding(5)
                    
                }
            }
        }
        
    }
    
}

#Preview {
    ViewAllQuizList()
       
}
