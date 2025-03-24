import SwiftUI
import SCComponents
import SCTokens

struct TagView: View {
    
    private let items: [TagItemModel]
    
    init(items: [TagItemModel]) {
        self.items = items
    }

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem(.fixed(Sizing.sizing5x))], content: {
                ForEach(items) { item in
                    TagItem(text: item.text)
                }
            })
        }
        .scrollIndicators(.never)
    }
}

#Preview {
    TagView(
        items: [
            TagItemModel(text: "Math"),
            TagItemModel(text: "Algebra"),
            TagItemModel(text: "English"),
            TagItemModel(text: "Science")
        ]
    ).padding()
}
