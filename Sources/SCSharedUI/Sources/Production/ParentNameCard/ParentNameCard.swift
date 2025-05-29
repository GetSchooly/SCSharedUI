

import SwiftUI
import SCTokens
import SCComponents

public struct ParentNameCard: View {
    
    public init(){
        
    }
    
    
    public var body: some View {
        HStack(){
            SDImage(.remote(url: "https://picsum.photos/id/103/200/200", contentMode: .fill))
                .frame(width: Sizing.profileImageSize - Spacing.spacing2x, height: Sizing.profileImageSize - Spacing.spacing2x)
                .background(Color.royalBlue)
                .clipShape(.circle)
                .frame(width: Sizing.profileImageSize, height: Sizing.profileImageSize)
                    .background(Color.royalBlue10)
                    .clipShape(.circle)
                    .padding(.top, Spacing.spacing5x)
                    .padding(.bottom, Spacing.spacing5x)
                    .padding(.leading , 10)
            VStack(alignment: .leading) {
                SDText("Akash Nairhfjkdhgjhfkjdsjghkfd", style: .size400(weight: .bold, theme: .darkGray, alignment: .leading))
                    .lineLimit(1)
                    .padding(.trailing , Spacing.spacing2xHalf)
                SDText("Guardian of Agilena and 2 others kndfkjhgklhlfkds ", style: .size100(weight: .medium, theme: .primary, alignment: .leading))
                    .padding(.trailing, Spacing.spacing2xHalf)
                    .lineLimit(2)
            }
            
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing4x))
        .shadow(.defaultGrayElevation)
        .padding()
    }
}

private extension Sizing {
    static let profileImageSize: CGFloat = (Sizing.sizing4x + Sizing.sizing2xHalf) * Sizing.sizing1x
}

#Preview {
    ParentNameCard()
}
