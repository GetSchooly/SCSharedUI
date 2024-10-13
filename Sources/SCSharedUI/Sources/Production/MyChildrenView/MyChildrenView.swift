import SwiftUI
import SCTokens
import SCComponents

public struct MyChildrenView: View {
    
//    init() {
//        Font.loadMyFonts
//    }
//    
    public var body: some View {
        GeometryReader { geometry in
            VStack {
                titleAndFindMoreView
                    .frame(height: Spacing.spacing2x)
                    .padding(.horizontal, Spacing.spacing4x)
                ScrollView(.horizontal) {
                    MyChildrenGridView(proxy: geometry)
                }
                .scrollIndicators(.never)
            }
        }
    }
    
    @ViewBuilder
    private var titleAndFindMoreView: some View {
        HStack {
            SDText("My Children", style: .size100(weight: .semiBold, theme: .primary, alignment: .leading))
            Spacer()
            SDButton("Find your children",
                     buttonType: .noStyle(.size90(weight: .bold, theme: .royalBlue, alignment: .trailing)),
                     icon: .local(resource: Icons.ic_plus.value, iconSize: .small, contentMode: .fit)) {
                
            }
        }
    }
}

private struct MyChildrenGridView: View {
    
    let proxy: GeometryProxy
    
    private let items = 1...50
    private let columns = [
        GridItem(.adaptive(minimum: 120))
    ]

    var body: some View {
        LazyHGrid(rows: columns, alignment: .center, spacing: Spacing.spacing4x) {
            Spacer(minLength: -Spacing.spacing1x)
            ForEach(items, id: \.self) { item in
                StudentBasicProfileCardView()
                    .frame(width: (proxy.size.width/2) - Spacing.spacing4x, height: Constants.rowHeight)
            }
        }
        .frame(height: Constants.gridViewHeight)
    }
}

private struct Constants {
    static let gridViewHeight: CGFloat = 212
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
