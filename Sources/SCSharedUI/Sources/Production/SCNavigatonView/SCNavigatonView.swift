import SwiftUI
import SCTokens
import SCComponents

public struct SCNavigatonView<Content>: View where Content: View {
    
    private let title: String
    private let hideBackButton: Bool
    private let rightButtons: [AnyView]
    private let content: Content
    
    public init(title: String, hideBackButton: Bool = false, rightButtons: [AnyView] = [], content: Content) {
        self.title = title
        self.hideBackButton = hideBackButton
        self.rightButtons = rightButtons
        self.content = content
        Font.loadMyFonts
    }
    
    public var body: some View {
        NavigationStack {
            ZStack(content: {
                VStack {
                    ZStack(alignment: .center) {
                        SDText(title, style: .size400(weight: .semiBold, theme: .primary, alignment: .center))
                            .frame(alignment: .center)
                        
                        HStack(content: {
                            if !hideBackButton {
                                backButton
                            }
                            Spacer()
                            righButtonView
                                .padding(.trailing, Spacing.spacing3x)
                        })
                    }
                    contentView
                }
                .navigationBarHidden(true)
            })
            .background(Color.appBackground)
        }
    }
    
    private var contentView: some View {
        ZStack(content: {
            content
        })
        .padding(.top, Spacing.spacing5x)
        .background(Color.white)
        .clipShape(
            .rect(topLeadingRadius: CornerRadius.cornerRadiusBaseView, topTrailingRadius: CornerRadius.cornerRadiusBaseView, style: .continuous)
        )
        .ignoresSafeArea(edges: .bottom)
        .shadow(.defaultGrayElevation)
    }
    
    private var backButton: some View {
        SDButton("", buttonType: .noStyle(), icon: .local(resource: Icons.ic_back.value, iconSize: .large)) {
            
        }
        .padding(.leading, Spacing.spacing3x)
    }
    
    @ViewBuilder
    private var righButtonView: some View {
        if !hideBackButton {
            if rightButtons.isEmpty {
                Rectangle().fill(Color.clear).frame(width: Spacing.spacing12x)
            } else {
                HStack {
                    Spacer()
                    ForEach(0..<rightButtons.count, id: \.self) { index in
                        rightButtons[index]
                            .frame(width: Sizing.sizing10x, height:  Sizing.sizing10x)
                            .padding(.trailing, -Spacing.spacing2x)
                    }
                }
                .frame(maxWidth: Sizing.sizing3x * Sizing.sizing2xHalf)
                .clipped()
            }
        } else {
            EmptyView()
        }
    }
}

private extension CornerRadius {
    static let cornerRadiusBaseView: CGFloat = 20
}

#Preview {
    SCNavigatonView(title: "Test Title", rightButtons: [
        AnyView(SDButton("", buttonType: .noStyle(), icon: .local(resource: Icons.ic_plus.value, iconSize: .extraLarge)) {
            
        }),
//        AnyView(SDButton("", buttonType: .noStyle(), icon: .local(resource: Icons.ic_Fees.value, iconSize: .extraLarge)) {
//            
//        }),
//        AnyView(SDButton("Edit", buttonType: .noStyle()) {
//            
//        })
    ],
                    content: EmptyView())
}