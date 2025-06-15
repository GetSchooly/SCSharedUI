import SwiftUI
import SCTokens
import SCComponents

public struct MyChildrenView: View {

    @StateObject private var viewModel = MyChildrenViewModel()

    private var onTap: (() -> Void)?
    private let onFindChildren: (() -> Void)

    public init(onFindChildren: @escaping (() -> Void), onTap: (() -> Void)? = nil) {
        self.onFindChildren = onFindChildren
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
                    // viewModel.loadingState = .idle
                }
            }
        }
        .onChange(of: viewModel.shoudlFindChildren) { shoudlFindChildren in
            if shoudlFindChildren {
                onFindChildren()
            }
        }
        .task {
            viewModel.fetchAllMarkedChildren()
        }
    }

    private var mainContentView: some View {
        GeometryReader { geometry in
            VStack {
                titleAndFindMoreView
                ScrollView(.horizontal) {
                    MyChildrenGridView(viewModel: viewModel, proxy: geometry, onTap:  {
                        onTap?()
                    })
                }
                .scrollIndicators(.never)
            }
            .scrollIndicators(.never)
        }
    }

    @ViewBuilder
    private var titleAndFindMoreView: some View {
        HStack(alignment: .center) {
            SDText("My Children", style: .size100(weight: .semiBold, theme: .primary, alignment: .leading))
            Spacer()
            SDButton("Find your children",
                     buttonType: .noStyle(.size90(weight: .bold, theme: .royalBlue, alignment: .trailing)),
                     icon: .local(resource: Icons.ic_plus.value, iconSize: .small, contentMode: .fit)) {
                onFindChildren()
            }
        }
        .padding(.horizontal, Spacing.spacing4x)
        .padding(.bottom, -Spacing.spacing3x)
        .frame(width: nil, height: Spacing.spacing5x)
    }
}

struct MyChildrenGridView: View {

    private var viewModel: MyChildrenViewModel
    private let proxy: GeometryProxy
    private let profileType: StudentProfile
    @State private var contentSizeHeight = CGFloat.zero

    private let columns = [
        GridItem()
    ]

    private var onTap: (() -> Void)?
    private var onConnect: ((StudentData) -> Void)?

    init(viewModel: MyChildrenViewModel, proxy: GeometryProxy, profileType: StudentProfile = .advanced, onConnect: ((StudentData) -> Void)? = nil, onTap: (() -> Void)? = nil) {
        self.viewModel = viewModel
        self.proxy = proxy
        self.onConnect = onConnect
        self.onTap = onTap
        self.profileType = profileType
    }

    var body: some View {
        LazyHGrid(rows: columns, spacing: Spacing.spacing4x) {
            Spacer(minLength: Spacing.spacing1x)
            ForEach(viewModel.markedChildren, id: \.self) { child in
                let profileViewModel = StudentProfileCardViewModel(student: child)
                StudentProfileCardView(viewModel: profileViewModel, type: profileType, onTapConnect: {
                    self.onConnect?(child)
                }, onTap: {
                    self.onTap?()
                })
                    .frame(width: (proxy.size.width/2) - Spacing.spacing4x, height: Sizing.rowHeight)
                    .overlay {
                        GeometryReader(content: { geometry in
                            Color.clear.onAppear(perform: {
                                contentSizeHeight = geometry.size.height
                            })
                        })
                    }
            }
        }
        .frame(height: contentSizeHeight + Spacing.spacing6x)
    }
}

private struct Sizing {
    static let gridViewHeight: CGFloat = 204
    static let rowHeight: CGFloat = 180
}

extension MyChildrenView: HasExamples {
    static var examples: [Example] {
        [Example("MyChildrenGridView", width: 300, height: 300) {
            MyChildrenView {}
        }]
    }
}

#Preview {
    VStack(alignment: .center, content: {
        MyChildrenView {}
    })
    .frame(height: 300)
}
