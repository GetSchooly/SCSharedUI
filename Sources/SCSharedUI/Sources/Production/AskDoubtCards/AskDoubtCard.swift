import SwiftUI
import SCComponents
import SCTokens

public enum AskDoubtCardType {
    case onlyText, withImage
}

public struct AskDoubtCard: View {
    
    private let cardType: AskDoubtCardType
    
    //TODO: - to fix enum AskDoubtCardType - handle only 1 common card view with image
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
            questionTitle("")
            footerView
        }
    }
    
    private var inboxCardViewImages: some View {
        VStack(alignment: .center) {
            questionTitle("")
            messageContentWithImageView()
            footerView.padding(.vertical, Spacing.spacing1x)
        }
    }
    
    @ViewBuilder
    private func questionTitle(_ content: String) -> some View {
        SDText("Give examples of infinitely many open sets in R , the intersection of which is (i) open (ii) closed (iii) neither open nor  open (ii) closed (iii) neither open nor", style: .size100(weight: .medium, theme: .primary, alignment: .leading))
            .frame(height: .infinity)
    }
    
    @ViewBuilder
    private func messageContentWithImageView() -> some View {
        HStack {
            imagesCollection
            Spacer()
        }
        .padding(.leading, Spacing.spacing3x)
        .padding(.top, Spacing.spacing1x)
    }
    
    private var imagesCollection: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem(.fixed(Sizing.questionImageViewHeight))], content: {
                ForEach(0..<4) { _ in
                    SDImage(.remote(url: "https://picsum.photos/id/103/200/200", contentMode: .fill))
                        .frame(width: Sizing.sizing10x * (Sizing.sizing1x - Sizing.sizing0xQuarter), height: Sizing.sizing10x * Sizing.sizing0xHalf)
                        .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing2x))
                }
            })
        }
        .scrollIndicators(.never)
    }
    
    @ViewBuilder
    private var footerView: some View {
        HStack(alignment: .top, spacing: Spacing.spacing1x) {
            VStack(content: {
                tags
                    .padding(.top, Spacing.spacing2x)
                    .padding(.bottom, Spacing.spacing2x)
                
                numberOfViewed
            }).padding(.leading, Spacing.spacing2x)
            userView
        }
    }
    
    @ViewBuilder
    private var numberOfViewed: some View {
        HStack(alignment: .center, spacing: Spacing.spacing1x) {
            SDImage(.local(resource: Icons.ic_Fees.value, iconSize: .small))
            SDText("Viewed 16 times", style: .size75(weight: .semiBold, theme: .primary, alignment: .leading))
            Spacer()
        }
    }
    
    private var tags: some View {
        TagView(items: [
            TagItemModel(text: "Math"),
            TagItemModel(text: "Algebra")
        ])
        .frame(height: Sizing.sizing5x)
    }
    
    private var userView: some View {
        return VStack(alignment: .leading, spacing: Spacing.spacing1x) {
            SDText("asked Dec 17, 2024 at 21:35", style: .size75(weight: .regular, theme: .secondry, alignment: .leading))
            HStack {
                SDImage(.remote(url: "https://picsum.photos/id/103/200/200", contentMode: .fill))
                    .frame(width: Sizing.sizing6x, height: Sizing.sizing6x )
                    .clipShape(.circle)
                SDText("Akash kr. Anand", style: .size75(weight: .medium, theme: .royalBlue, alignment: .leading))
            }
        }
        .lineLimit(1)
        .minimumScaleFactor(0.7)
        .padding(.all, Spacing.spacing2x)
        .background(Color.lightBlue)
        .clipShape(.rect(cornerRadius: CornerRadius.userBGView))
    }
    
    private func setupUI() {
        // setup for the UI
    }
    
    private func initViewModel() {
        // setup for the ViewModel
        // viewModel.fetchData()
    }
    
}

extension AskDoubtCard: HasExamples {
    static var examples: [Example] {
        [Example("AskDoubtCard only Text", width: 300, height: 300) {
            AskDoubtCard(cardType: .onlyText)
        },
         Example("AskDoubtCard with Image", width: 300, height: 300) {
             AskDoubtCard(cardType: .withImage)
         }]
    }
}

private extension CornerRadius {
    static let userBGView: CGFloat = Sizing.sizing2x
}

private extension Sizing {
    static let questionImageViewHeight: CGFloat = 80
}

#Preview {
    VStack {
        AskDoubtCard(cardType: .withImage)
            //.frame(height: 200)
Divider()
        AskDoubtCard(cardType: .onlyText)
            //.frame(height: 120)
    }
    .padding()
}
