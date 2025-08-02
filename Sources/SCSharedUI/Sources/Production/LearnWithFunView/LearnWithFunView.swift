import SwiftUI
import SCTokens
import SCComponents

public struct LearnWithFunView: View {
    private let tapOnSeeAll:(() -> Void)
    
    public init(tapOnSeeAll: @escaping (() -> Void)) {
        self.tapOnSeeAll = tapOnSeeAll
        Font.loadMyFonts
    }
    
    public var body: some View {
        VStack {
            titleAndViewAllView
            ScrollView(.horizontal) {
                LearnWithFunGridView()
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
                self.tapOnSeeAll()
            }
        }
        .padding(.horizontal, Spacing.spacing4x)
        .frame(width: nil, height: Spacing.spacing5x)
    }
}

private struct LearnWithFunGridView: View {
    @State private var contentSizeHeight = Sizing.sizing0x

    private let items = 1...3
    private let columns = [
        GridItem()
    ]

    var body: some View {
        LazyHGrid(rows: columns, spacing: Spacing.spacing4x) {
            Spacer(minLength: Spacing.spacing1x)
            ForEach(items, id: \.self) { item in
                LearnWithFunCardView()
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

extension LearnWithFunView: HasExamples {
    static var examples: [Example] {
        [Example("LearnWithFunView", width: 390, height: 300) {
            MyChildrenView {}
        }]
    }
}

#Preview {
    VStack(alignment: .center, content: {
        LearnWithFunView(){}
    })
    .frame(height: 300)
}

