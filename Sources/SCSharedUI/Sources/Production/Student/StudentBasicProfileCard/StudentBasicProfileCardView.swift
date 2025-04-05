import SwiftUI
import SCTokens
import SCComponents

public enum StudentProfile {
    case basic
    case advanced
}

public struct StudentProfileCardView: View {
    
    @Environment(\.mainWindowSize) var mainWindowSize
    
    private let type: StudentProfile
    private let onTapConnect: (() -> Void)?
    private let onTap: (() -> Void)?
    
    public init(type: StudentProfile = .basic, onTapConnect: (() -> Void)? = nil, onTap: (() -> Void)? = nil) {
        self.type = type
        self.onTapConnect = onTapConnect
        self.onTap = onTap
        Font.loadMyFonts
    }
    
    public var body: some View {
        Group {
            switch type {
            case .basic:
                basicProfileView
            case .advanced:
                advancedProfileView
            }
        }
        .padding(Spacing.spacing4x)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: Sizing.sizing4x))
        .shadow(SDElevation.defaultGrayElevation)
        .onTapGesture {
            onTap?()
        }
    }
    
    private var basicProfileView: some View {
        VStack(alignment: .center) {
            profileImage.padding(.bottom, Spacing.spacing2x)
            studentBasicInfo
        }
//        .padding(.horizontal, Spacing.spacing2x)
//        .padding(.vertical, Spacing.spacing3x)
        .frame(maxWidth: mainWindowSize.width * Constants.widthPercentage, maxHeight: Constants.viewHeight)
    }
    
    private var advancedProfileView: some View {
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
            studentAdvancedInfoView
        }
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
    
    private var studentAdvancedInfoView: some View {
        VStack(alignment: .leading) {
            studentBasicInfo
            SDButton("Connect",
                     buttonType: .primaryButton(.size90(weight: .semiBold, theme: .standard, alignment: .leading)),
                     spacing: Sizing.sizing2x, maxSize: true) {
                onTapConnect?()
            }
                     .frame(height: Constants.connectButtonHeight)
        }
    }
    
    private var studentBasicInfo: some View {
        VStack(alignment: type == .advanced ? .leading : .center) {
            SDText("Ram Kumar", style: .size100(weight: .bold, theme: .primary))
                .padding(.bottom, type == .advanced ? Spacing.spacing0x : Spacing.spacing1x)
            SDText("XI-B | Roll no: 04", style: .size90(weight: .regular, theme: .secondry))
        }
    }
}

private struct Constants {
    static let profileImageSize: CGFloat = 60.0
    static let connectButtonHeight: CGFloat = 32
    static let widthPercentage: CGFloat = 0.32
    static let viewHeight: CGFloat = 125
}

extension StudentProfileCardView: HasExamples {
    static var examples: [Example] {
        [Example("BasicProfileCardView", width: 220, height: 120) {
            StudentProfileCardView()
        },
         Example("AdvanceProfileCardView", width: 220, height: 180) {
            StudentProfileCardView(type: .advanced)
         }]
    }
}

#Preview {
    VStack {
        StudentProfileCardView(type: .advanced)
            .padding(.bottom, 32)
        
        StudentProfileCardView()
    }
    .environment(\.mainWindowSize, .init(width: 320, height: 580))
}
