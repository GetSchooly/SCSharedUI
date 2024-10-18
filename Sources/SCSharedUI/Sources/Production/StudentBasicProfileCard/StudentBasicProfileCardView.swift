import SwiftUI
import SCTokens
import SCComponents

public struct StudentBasicProfileCardView: View {
    
    public init() {
        
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                profileImage
                Spacer()
                SDText("PAID", style: .size50(weight: .bold, theme: .standard))
                    .padding(Sizing.sizing0xHalf + Sizing.sizing0xQuarter)
                    .background(.green)
                    .clipShape(.rect(cornerRadius: Sizing.sizing1x))
            }
            .padding(.bottom, Spacing.spacing2x)
            studentBasicInfoView
        }
        .padding(Spacing.spacing4x)
        .background(Color.appBackground)
        .clipShape(.rect(cornerRadius: Sizing.sizing4x))
        .shadow(SDElevation.defaultGrayElevation)
    }
    
    private var profileImage: some View {
        SDImage(.remote(url: "https://picsum.photos/seed/picsum/200/300"))
            .frame(width: Constants.profileImageSize, height: Constants.profileImageSize, alignment: .center)
            .clipShape(.circle)
            .border(.init(
                cornerRadius: Constants.profileImageSize/Sizing.sizing0xHalf,
                color: .royalBlue10,
                width: Sizing.sizing2x)
            )
    }
    
    private var studentBasicInfoView: some View {
        VStack(alignment: .leading) {
            SDText("Ram Kumar", style: .size100(weight: .bold, theme: .primary))
            SDText("XI-B | Roll no: 04", style: .size90(weight: .regular, theme: .secondry))
            Spacer(minLength: Sizing.sizing3x)
            SDButton("Connect",
                     buttonType: .primaryButton(.size90(weight: .semiBold, theme: .standard, alignment: .leading)),
                     spacing: Sizing.sizing2x, maxSize: true) {
                
            }
                     .frame(height: Constants.connectButtonHeight)
        }
    }
}

private struct Constants {
    static let profileImageSize: CGFloat = 60.0
    static let connectButtonHeight: CGFloat = 32
}

extension StudentBasicProfileCardView: HasExamples {
    static var examples: [Example] {
        [Example("StudentBasicProfileCardView", width: 220, height: 180) {
            StudentBasicProfileCardView()
        }]
    }
}

#Preview {
    StudentBasicProfileCardView()
        .frame(width: 200, height: 180)
}
