import SwiftUI
import SCTokens
import SCComponents

public enum UserType {
    case school
    case parent
}

public struct UserProfileCardView: View {
    
    private let userType: UserType
    
    public init(userType: UserType = .school) {
        self.userType = userType
    }
    
    public var body: some View {
        ZStack {
            studentBasicInfoView
                .frame(minWidth: 160, maxHeight: .infinity)
                .background(Color.appBackground)
                .clipShape(.rect(cornerRadius: Sizing.sizing4x))
                .shadow(SDElevation.defaultGrayElevation)
            profileImage
        }
    }
    
    private var profileImage: some View {
        SDImage(.remote(url: "https://picsum.photos/seed/picsum/200/300"))
            .frame(width: Constants.profileImageSize, height: Constants.profileImageSize, alignment: .center)
            .clipShape(.rect(cornerRadius: Sizing.sizing4x))
            .padding(EdgeInsets(top: Constants.profileImageTopPadding, leading: 0, bottom: 0, trailing: 0))
    }
    
    private var studentBasicInfoView: some View {
        VStack(alignment: .center) {
            SDText("SUMIT RAY", style: .size200(weight: .semiBold, theme: .primary))
            SDText("Mathematcis", style: .size100(weight: .regular, theme: .secondry))
//            SDButton("Connect", buttonType: .primaryButton(.size100(weight: .regular, theme: .standard, alignment: .leading)), spacing: Sizing.sizing2x, maxWidth: true)
            
        }
        .padding(EdgeInsets(top: Constants.basicInfoTopPaddig, leading: Spacing.spacing4x, bottom: Spacing.spacing4x, trailing: Spacing.spacing4x))
    }
}

private struct Constants {
    static let profileImageSize: CGFloat = 100
    static let profileImageTopPadding: CGFloat = -120
    static let basicInfoTopPaddig: CGFloat = 50
}

extension UserProfileCardView: HasExamples {
    static var examples: [Example] {
        [Example("UserProfileCardView", width: 180, height: 140) {
            UserProfileCardView()
        }]
    }
}

#Preview {
    UserProfileCardView()
        .frame(height: 140)
}
