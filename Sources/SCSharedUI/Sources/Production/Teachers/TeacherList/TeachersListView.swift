import SwiftUI
import SCComponents
import SCTokens

public struct TeachersListView: View {
    
    @ObservedObject var viewModel: TeacherListViewModel
    @Environment(\.mainWindowSize) var mainWindowSize
    
    public init(viewModel: TeacherListViewModel) {
        self.viewModel = viewModel
        setupUI()
        initViewModel()
    }
    
    private func setupUI(){
        // setup for the UI
    }
    
    private func initViewModel() {
        // setup for the ViewModel
        // viewModel.fetchData()
    }
    
    public var body: some View {
        studentTeachersList
    }

    private var studentTeachersList: some View{
        ScrollView {
            Spacer(minLength: Spacing.spacing4x)
            VStack(spacing: Spacing.spacing4x) {
                TeacherProfileCard()
                    .frame(width: mainWindowSize.width/2)
                    .shadow(.defaultGrayElevation)
                subjectTeachersList
            }
        }
        
    }

    private let columns: [GridItem] = [GridItem(.flexible()),
                                       GridItem(.flexible())]
    private var subjectTeachersList: some View {
        VStack(alignment: .leading) {
            SDText("Subject wise", style:
                    .size200(weight: .semiBold,
                             theme: .primary,
                             alignment: .leading)
            )
            .frame(height: Sizing.sizing10x)
            
            LazyVGrid(columns: columns){
                ForEach(viewModel.teacherList){ teacher in
                    TeacherProfileCard()
                        .frame(width: mainWindowSize.width/2.4)
                        .padding(.trailing, Spacing.spacing1x)
                        .padding(.vertical, Spacing.spacing2x)
                        .shadow(.defaultGrayElevation)
                }
            }
        }
        .padding(.horizontal, Spacing.spacing4x)
    }
}

#Preview {
    TeachersListView(viewModel: TeacherListViewModel())
        .environment(\.mainWindowSize, UIScreen.main.bounds.size)
}


