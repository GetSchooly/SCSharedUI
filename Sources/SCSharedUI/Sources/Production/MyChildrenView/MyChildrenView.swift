import SwiftUI
import SCTokens
import SCComponents

public struct MyChildrenView: View {

    private var onTap: (() -> Void)?
    
    public init(onTap: (() -> Void)? = nil) {
        self.onTap = onTap
    }
    
    public var body: some View {
        GeometryReader { geometry in
            VStack {
                titleAndFindMoreView
                ScrollView(.horizontal) {
                    MyChildrenGridView(proxy: geometry) {
                        onTap?()
                    }
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
                
            }
        }
        .padding(.horizontal, Spacing.spacing4x)
        .padding(.bottom, -Spacing.spacing3x)
        .frame(width: nil, height: Spacing.spacing5x)
    }
}

private struct MyChildrenGridView: View {
    
    private let proxy: GeometryProxy
    @State private var contentSizeHeight = CGFloat.zero
    
    private let items = 1...3
    private let columns = [
        GridItem()
    ]

    private var onTap: (() -> Void)?
    
    init(proxy: GeometryProxy, onTap: (() -> Void)? = nil) {
        self.proxy = proxy
        self.onTap = onTap
    }
    
    var body: some View {
        LazyHGrid(rows: columns, spacing: Spacing.spacing4x) {
            Spacer(minLength: Spacing.spacing1x)
            ForEach(items, id: \.self) { item in
                StudentProfileCardView(onTapConnect: {
                    
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
            MyChildrenView()
        }]
    }
}

#Preview {
    VStack(alignment: .center, content: {
        MyChildrenView()
    })
    .frame(height: 300)
}
