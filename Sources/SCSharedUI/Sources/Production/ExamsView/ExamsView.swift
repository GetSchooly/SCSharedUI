import SwiftUI
import SCTokens
import SCComponents

public struct ExamsView: View {
    
    @ObservedObject var viewModel: ExamsViewModel
    
    public init(viewModel: ExamsViewModel) {
        self.viewModel = viewModel
        setupUI()
        initViewModel()
        Font.loadMyFonts
    }
    
    private func setupUI(){
        // setup for the UI
    }
    
    private func initViewModel() {
        // setup for the ViewModel
        // viewModel.fetchData()
    }
    
    public var body: some View {
        SCNavigatonView(title: "Exams", hideBackButton: false) {
            examListDetailView
        }
    }
    
    private var examListDetailView: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: Spacing.spacing4x) {
                topActionsView
                SDText("Half-Yearly Exam",
                       style: .size300(weight: .semiBold, theme: .primary, alignment: .leading))
            }
            .padding(.top, Spacing.spacing2x)
            .padding(.horizontal, Spacing.spacing5x)
            examlist
        }
    }
    
    private var examlist: some View {
        List(viewModel.examDetailList) { inbox in
            ExamCardView()
                .padding(.vertical, Spacing.spacing1x)
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
    
    private var topActionsView: some View {
        HStack(spacing: Spacing.spacing3x) {
            SDButton("Upcoming",
                     buttonType: .primaryButton(.size100(weight: .semiBold,  theme: .standard, alignment: .center)),
                     spacing: Spacing.spacing2x) {
                
            }
            
            SDButton("Completed" ,
                     buttonType: .secondryBorderd(.size100(weight: .semiBold, theme: .secondry, alignment: .center)),
                     spacing: Spacing.spacing2x) {
                // upcoming exam list request..
            }
        }
    }
}

#Preview {
    ExamsView(viewModel: ExamsViewModel())
}
