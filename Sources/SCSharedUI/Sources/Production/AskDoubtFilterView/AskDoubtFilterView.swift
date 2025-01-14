import SwiftUI
import SCComponents
import SCTokens

public enum PrimaryFilterOption {
    case filter, newest, unanswered, askQuestion
}

public struct AskDoubtFilterView: View {
   
    private let onTapButton:((_ options: PrimaryFilterOption) -> Void)
    
    public init(onTapButton: @escaping (_: PrimaryFilterOption) -> Void) {
        self.onTapButton = onTapButton
    }
    
    public var body: some View {
        HStack(spacing: Spacing.spacing2x, content: {
            ScrollView(.horizontal) {
                optionsGridView
            }
            .scrollIndicators(.never)
            .frame(width: nil, height: Sizing.sizing8x, alignment: .leading)
            
            SDButton("Ask Question", buttonType: .primaryButton(.size90(weight: .semiBold, theme: .standard)), spacing: Spacing.spacing4x) {
                onTapButton(.askQuestion)
            }
            .frame(height: Sizing.sizing10x)
            .clipShape(.rect(cornerRadius: CornerRadius.askQuestion))
            .padding(.leading, Spacing.spacing4x)
        })
        .padding(.horizontal, Spacing.spacing5x)
    }
    
    private var optionsGridView: some View {
        LazyHGrid(rows: [GridItem(.flexible(minimum: Sizing.sizing10x, maximum: Sizing.sizing10x * Sizing.sizing1x))], content: {
            SDButton("Filter", buttonType: .blackTextSecondryBordered(.size75(weight: .semiBold, theme: .primary)), spacing: Spacing.spacing3x, icon: .local(resource: Icons.ic_Fees.value, iconSize: .medium, placement: .right)) {
                onTapButton(.filter)
            }
            
            SDButton("Newest", buttonType: .blackTextSecondryBordered(.size75(weight: .semiBold, theme: .primary)), spacing: Spacing.spacing4x) {
                onTapButton(.newest)
            }
            
            SDButton("Unanswered", buttonType: .blackTextSecondryBordered(.size75(weight: .semiBold, theme: .primary)), spacing: Spacing.spacing4x) {
                onTapButton(.unanswered)
            }
        })
    }
}

private extension CornerRadius {
    static let askQuestion: CGFloat = Sizing.sizing10x
}

extension AskDoubtFilterView: HasExamples {
    static var examples: [Example] {
        [Example("AskDoubtFilterView", width: 300, height: 300) {
            AskDoubtFilterView { _ in }
        }]
    }
}

#Preview {
    AskDoubtFilterView { _ in
        
    }
}
