import SwiftUI
import SCTokens
import SCComponents

struct StudentBasicProfileCardView: View {
    var body: some View {
        VStack(alignment: .leading) {
            profileImage
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
    }
    
    private var studentBasicInfoView: some View {
        VStack(alignment: .leading) {
            SDText("Ram Kumar", style: .size200(weight: .medium, theme: .primary))
            SDText("XI-B | Roll no: 04", style: .size100(weight: .regular, theme: .secondry))
            Spacer(minLength: Sizing.sizing2x)
            SDButton("Connect",
                     buttonType: .primaryButton(.size100(weight: .regular, theme: .standard, alignment: .leading)),
                     spacing: Sizing.sizing2x, maxSize: true) {
                
            }
        }
    }
}

private struct Constants {
    static let profileImageSize = 80.0
}

extension StudentBasicProfileCardView: HasExamples {
    static var examples: [Example] {
        [Example("StudentBasicProfileCardView", width: 220, height: 180) {
            StudentBasicProfileCardView()
        }]
    }
}
