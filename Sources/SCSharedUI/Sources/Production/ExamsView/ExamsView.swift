import SwiftUI
import SCTokens
import SCComponents

public struct ExamsView: View {
   
    @ObservedObject var viewModel: ExamsViewModel = .init()
    private let studentId: String
    
    public init(studendID: String) {
        self.studentId = studendID
        Font.loadMyFonts
       
    }

    public var body: some View {
        Group {
            switch viewModel.loadingState.viewLoadingState {
            case .idle, .loading:
                examListDetailView
                    .shimmer(isLoading: true)

            case .loaded:
                examListDetailView

            case .failed(_):
                EmptyView()
            }
        }
        .task {
            viewModel.fetchStudentExamBy(studentId: studentId, action: "")
        }
    }
    
    private var examListDetailView: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: Spacing.spacing4x) {
                topActionsView
                SDText(viewModel.examDetailList.first?.exam_type ?? "",
                       style: .size300(weight: .semiBold, theme: .primary, alignment: .leading))
            }
            .padding(.top, Spacing.spacing2x)
            .padding(.horizontal, Spacing.spacing5x)
            examlist
        }
    }
    
    private var examlist: some View {
        List(Array(viewModel.examDetailList.enumerated()), id: \.element.id ) { index, exam in
            
            let bgColor = viewModel.colors[index % viewModel.colors.count] // repeat color
            ExamCardView(bgColor)
                .padding(.vertical, Spacing.spacing1x)
                .listRowSeparator(.hidden)
                 
        }
        .listStyle(.plain)
    }
    
    private var topActionsView: some View {
        HStack(spacing: Spacing.spacing3x) {
            SDButton("Upcoming",
                     buttonType: viewModel.isPending ? .primaryButton(.size100(weight: .semiBold,  theme: .standard, alignment: .center)) : .secondryBorderd(.size100(weight: .semiBold, theme: .secondry, alignment: .center)),
                     spacing: Spacing.spacing2x) {
                viewModel.isPending.toggle()
            }
            
            SDButton("Completed" ,
                     buttonType: viewModel.isPending ? .secondryBorderd(.size100(weight: .semiBold, theme: .secondry, alignment: .center)) : .primaryButton(.size100(weight: .semiBold,  theme: .standard, alignment: .center)),
                     spacing: Spacing.spacing2x) {
                // upcoming exam list request..
                viewModel.isPending.toggle()
            }
        }
        .animation(.easeInOut, value: viewModel.isPending)
    }
}

#Preview {
    ExamsView(studendID: "141")
}
