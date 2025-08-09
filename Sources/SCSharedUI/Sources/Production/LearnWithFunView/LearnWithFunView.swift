import SwiftUI
import SCTokens
import SCComponents

struct LearnWithFunHomeView: View {
    @ObservedObject private var viewModel: QuizSubjectsViewModel
    private let onTapSeeAll:(() -> Void)?

    init(viewModel: QuizSubjectsViewModel, onTapSeeAll: (() -> Void)? = nil) {
        self.viewModel = viewModel
        self.onTapSeeAll = onTapSeeAll
    }

    public var body: some View {
        VStack {
            titleAndViewAllView
            ScrollView(.horizontal) {
                LearnWithFunGridView(viewModel: viewModel)
            }
            .scrollIndicators(.never)
            .padding(.top, -Spacing.spacing2x)
        }
    }

    @ViewBuilder
    private var titleAndViewAllView: some View {
        HStack(alignment: .center) {
            SDText("Learn with fun play quiz", style: .size100(weight: .semiBold, theme: .primary, alignment: .leading))
            Spacer()
            SDButton("View all",
                     buttonType: .noStyle(.size90(weight: .bold, theme: .royalBlue, alignment: .trailing))) {
                self.onTapSeeAll?()
            }
        }
        .padding(.horizontal, Spacing.spacing4x)
        .frame(width: nil, height: Spacing.spacing5x)
    }
}

fileprivate struct LearnWithFunGridView: View {
    @ObservedObject private var viewModel: QuizSubjectsViewModel
    @State private var contentSizeHeight = Sizing.sizing0x

    private let columns = [
        GridItem()
    ]

    init(viewModel: QuizSubjectsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        LazyHGrid(rows: columns, spacing: Spacing.spacing4x) {
            Spacer(minLength: Spacing.spacing1x)
            ForEach(viewModel.quizSubjects.prefix(5)) { subject in
                LearnWithFunCardView(
                    subjectImageUrl: subject.icon,
                    subjectName: subject.title,
                    numberOfTakers: subject.attemptedCount
                )
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

extension LearnWithFunHomeView: HasExamples {
    static var examples: [Example] {
        [Example("LearnWithFunView", width: 390, height: 300) {
            MyChildrenView {}
        }]
    }
}

#Preview {
    VStack(alignment: .center, content: {
        LearnWithFunHomeView(viewModel: QuizSubjectsViewModel()){}
    })
    .frame(height: 300)
}

