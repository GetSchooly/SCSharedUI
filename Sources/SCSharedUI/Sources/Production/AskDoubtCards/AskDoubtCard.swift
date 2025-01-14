import SwiftUI
import SCComponents
import SCTokens

public enum AskDoubtCardType {
    case onlyText, withImage
}

public struct AskDoubtCard: View {
    
    private let cardType: AskDoubtCardType
    
    public init(cardType: AskDoubtCardType = .onlyText) {
        self.cardType = cardType
        setupUI()
        initViewModel()
        Font.loadMyFonts
    }
    
    public var body: some View {
        switch cardType {
        case .onlyText:
            inboxCardView
        case .withImage:
            inboxCardViewImages
        }
    }
    
    private var inboxCardView: some View {
        VStack(alignment: .center) {
            HStack {
                SDText("Give examples of infinitely many open sets in R , the intersection of which is (i) open (ii) closed (iii) neither open nor", style: .size100(weight: .medium, theme: .primary, alignment: .leading))
                    .padding(.bottom, Spacing.spacing0x)
                viewsAnswersView
            }
            HStack(spacing: Spacing.spacing1x) {
                tags.padding(.leading, Spacing.spacing2x)
                userView
            }
            .frame(height: Sizing.sizing8x)
        }
    }
    
    private var inboxCardViewImages: some View {
        VStack(alignment: .center) {
            SDText("Give examples of infinitely many open sets in R , the intersection of which is (i) open (ii) closed (iii) neither open nor", style: .size100(weight: .medium, theme: .primary, alignment: .leading))
                .padding(.bottom, Spacing.spacing0x)
            messageContentWithImageView()
            HStack(spacing: Spacing.spacing1x) {
                tags.padding(.leading, Spacing.spacing3x)
                userView
            }
            .frame(height: Sizing.sizing8x)
        }
    }
    
    @ViewBuilder
    private func messageContentWithImageView() -> some View {
        HStack {
            HStack {
                SDImage(.remote(url: "https://picsum.photos/id/103/200/200", contentMode: .fill))
                    .frame(width: Sizing.sizing10x * (Sizing.sizing1x - Sizing.sizing0xQuarter), height: Sizing.sizing10x * Sizing.sizing0xHalf)
                    .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing2x))
                    
                
                SDImage(.remote(url: "https://picsum.photos/id/103/200/200", contentMode: .fill))
                    .frame(width: Sizing.sizing10x * (Sizing.sizing1x - Sizing.sizing0xQuarter), height: Sizing.sizing10x * Sizing.sizing0xHalf)
                    .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing2x))
            }

            Spacer()
            viewsAnswersView
        }
        .padding(.leading, Spacing.spacing3x)
        .padding(.top, Spacing.spacing1x)
    }
    
    private var viewsAnswersView: some View {
        Group {
            Rectangle().fill(Color.lightBlue)
                .frame(width: Sizing.sizing0xHalf, height: Sizing.sizing14x + Sizing.sizing1x)
                .padding(.horizontal, Spacing.spacing3x)

            VStack(alignment: .leading, spacing: Spacing.spacing2x) {
                SDText("16 views", style: .size75(weight: .semiBold, theme: .primary, alignment: .leading))
                SDText("2 answers", style: .size75(weight: .semiBold, theme: .primary, alignment: .leading))
            }
            .lineLimit(1)
            .frame(width: Sizing.sizing10x + Sizing.sizing7x, alignment: .leading)
        }
    }
    
    private var tags: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem(.fixed(20))], content: {
                TagItem(text: "Math")
                TagItem(text: "Algebra")
                TagItem(text: "Math")
                TagItem(text: "Algebra")
                TagItem(text: "Math")
                TagItem(text: "Algebra")
            })
        }
        .scrollIndicators(.never)
    }
    
    private var userView: some View {
        return HStack(spacing: Spacing.spacing1x) {
            SDImage(.remote(url: "https://picsum.photos/id/103/200/200", contentMode: .fill))
                .frame(width: Sizing.sizing5x, height: Sizing.sizing5x )
                .clipShape(.circle)
            SDText("Akash kr. Anand", style: .size75(weight: .medium, theme: .royalBlue, alignment: .leading))
            SDText("asked 1 hr ago", style: .size75(weight: .regular, theme: .secondry, alignment: .leading))
        }
        .lineLimit(1)
        .minimumScaleFactor(0.7)
    }
    
    private func setupUI() {
        // setup for the UI
    }
    
    private func initViewModel() {
        // setup for the ViewModel
        // viewModel.fetchData()
    }
    
}

private extension CornerRadius {
    static let tagItem: CGFloat = Sizing.sizing1x
}

private struct TagItem: View {
    let text: String
    
    var body: some View {
        SDText(text, style: .size75(weight: .semiBold, theme: .primary, alignment: .center))
            .padding(.horizontal, Spacing.spacing2x)
            .padding(.vertical, Spacing.spacing0xHalf)
            .background(Color.lightBlue)
            .clipShape(RoundedRectangle(cornerRadius: CornerRadius.tagItem))
    }
}

extension AskDoubtCard: HasExamples {
    static var examples: [Example] {
        [Example("AskDoubtCard only Text", width: 300, height: 300) {
            AskDoubtCard(cardType: .withImage)
        },
         Example("AskDoubtCard with Image", width: 300, height: 300) {
             AskDoubtCard(cardType: .withImage)
         }]
    }
}

#Preview {
    VStack {
        AskDoubtCard(cardType: .withImage)
            .frame(height: 200)

        AskDoubtCard(cardType: .onlyText)
            .frame(height: 120)
    }
    .padding()
}
