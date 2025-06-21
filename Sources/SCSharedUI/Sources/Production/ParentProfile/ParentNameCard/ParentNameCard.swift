import SwiftUI
import SCTokens
import SCComponents

public struct ParentNameCard: View {

    let parentProfileModel: ParentProfileModel

    public var body: some View {
        HStack {
            ZStack {
                SDImage(.remote(url: parentProfileModel.profileImage ?? "", contentMode: .fill))
                    .frame(width: Sizing.profileImageSize + Sizing.sizing1xHalf, height: Sizing.profileImageSize + Sizing.sizing1xHalf)
                    .clipShape(.circle)
                    .padding(Spacing.spacing1x)
            }
            .background(Color.royalBlue10)
            .clipShape(.circle)
            .padding(.leading, Spacing.spacing4x)
            
            VStack(alignment: .leading) {
                SDText(parentProfileModel.profileName ?? "", style: .size300(weight: .bold, theme: .primary, alignment: .leading))
                    .lineLimit(1)
                    .padding(.trailing , Spacing.spacing2xHalf)
                SDText(parentProfileModel.guradianDescription, style: .size90(weight: .regular, theme: .secondry, alignment: .leading))
                    .lineLimit(2)
            }
            .padding(.horizontal, Spacing.spacing2x)
            Spacer()
        }
        .frame(height: 88)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing4x))
        .shadow(.defaultGrayElevation)
    }
}

private extension Sizing {
    static let profileImageSize: CGFloat = Sizing.sizing14x
}

#Preview {
    ParentNameCard(parentProfileModel: ParentProfileModel.mockParent)
}
