import SwiftUI
import SCTokens
import SCComponents

public struct FindYourChildrenView: View {
    
    @StateObject private var viewModel = MyChildrenViewModel()
    @StateObject private var linkChildViewModel = LinkChildViewModel()
    @Environment(\.dismiss) var dismiss
    
    private var onTap: (() -> Void)?

    public init(onTap: (() -> Void)? = nil) {
        self.onTap = onTap
    }

    public var body: some View {
        Group {
            switch viewModel.loadingState.viewLoadingState {
            case .idle, .loading:
                mainContentView
                    .shimmer(isLoading: true)

            case .loaded:
                mainContentView

            case .failed(let error):
                LoadingViewHelper.errorView(errorMessage: error.localizedDescription) {
                    viewModel.fetchAllregisteredStudents()
                }
            }
        }
        .task {
            viewModel.fetchAllMarkedChildren()
        }
    }

    private var mainContentView: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                VStack {
                    titleView
                        .padding(.top, Spacing.spacing5x)
                    ScrollView(.horizontal) {
                        MyChildrenGridView(viewModel: viewModel, proxy: geometry, profileType: .basic, onConnect: { student in
                            linkChildViewModel.addChildIdToTrack(student.id)
                        }, onTap:  {
                            onTap?()
                        })
                    }
                    .scrollIndicators(.never)
                    .padding(.bottom, Spacing.spacing4x)
                    
                    SDButton("  Connect Profiles ",
                             buttonType: .primaryButton(.size100(weight: .semiBold, theme: .standard)), spacing: Spacing.spacing3x,
                             onTapAction: {
                        linkChildViewModel.linkChildredToParent()
                    })
                    .padding(.bottom, Spacing.spacing12x)
                }
            }
        }
    }

    @ViewBuilder
    private var titleView: some View {
        HStack(alignment: .center) {
            SDText("Connect your child, Track their progress", style: .size200(weight: .medium, theme: .primary, alignment: .leading))
                .lineLimit(0)
//            Spacer()
//            SDButton("",
//                     buttonType: .noStyle(),
//                     icon: .local(resource: Icons.ic_plus.value, iconSize: .large),
//                     onTapAction: {
//                dismiss()
//            })
        }
        .padding(.horizontal, Spacing.spacing4x)
        .padding(.bottom, Spacing.spacing2x)
    }
}

extension FindYourChildrenView: HasExamples {
    static var examples: [Example] {
        [Example("FindYourChildrenView", width: 300, height: 300) {
            FindYourChildrenView {}
        }]
    }
}

#Preview {
    VStack(alignment: .center, content: {
        FindYourChildrenView {}
    })
    .frame(height: 300)
}
