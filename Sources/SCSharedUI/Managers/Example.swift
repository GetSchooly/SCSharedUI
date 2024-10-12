import SwiftUI

protocol HasExamples {
   static var examples: [Example] { get }
}

struct Example: View {
    
    let title: String
    private let width: CGFloat
    private let height: CGFloat
    private let views: AnyView
    
    init(_ title: String,
         width: CGFloat, height: CGFloat, @ViewBuilder content: () -> some View) {
        self.title = title
        self.width = width
        self.height = height
        self.views = AnyView(content())
    }
    
    @ViewBuilder
    var body: some View {
        ScrollView {
            views
                .frame(width: width, height: height)
                .previewDisplayName(title)
                .preferredColorScheme(.light)
                .previewLayout(.device)
                .padding()
        }
    }
}

extension Example: Hashable {
    static func == (lhs: Example, rhs: Example) -> Bool {
        lhs.title == rhs.title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}
    
