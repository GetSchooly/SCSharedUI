import SwiftUI
import SCComponents
import SCTokens

struct TagItem: View {

    let text: String
    
    var body: some View {
        SDText(text, style: .size75(weight: .semiBold, theme: .primary, alignment: .center))
            .padding(.horizontal, Spacing.spacing2x)
            .padding(.vertical, Spacing.spacing0xHalf)
            .background(Color.lightBlue)
            .clipShape(RoundedRectangle(cornerRadius: CornerRadius.tagItem))
    }
}

private extension CornerRadius {
    static let tagItem: CGFloat = Sizing.sizing1x
}

#Preview {
    TagItem(text: "Tag")
}
