import SwiftUI
import SCComponents
import SCTokens

public struct TeacherProfileCard: View {
    
    @Environment(\.mainWindowSize) var mainWindowSize
    
    public init() {
        Font.loadMyFonts
    }
    
    public var body: some View {
        VStack {
            SDImage(.remote(url: "https://picsum.photos/id/103/200/200", contentMode: .fill))
                .frame(width: Sizing.profileImageSize, height: Sizing.profileImageSize)
                .background(Color.lightBlue)
                .clipShape(.circle)
                .padding(.top, Spacing.spacing4x)
            
            SDText("Teacher's name", style: .size100(weight: .semiBold, theme: .royalBlue, alignment: .leading))
                .padding(.top, Spacing.spacing4x)
            
            SDText("Class Teacher", style: .size90(weight: .regular, theme: .darkGray, alignment: .leading))
                .padding(.top, Spacing.spacing0x)
            
            contactButtons()
                .padding(.top, Spacing.spacing1x)
            
            VStack {
                SDText("Lorem ipsum is used to emphasize the design over.Lorem ipsum is used to emphasize the design over.Lorem ipsum is used to emphasize the design over.Lorem ipsum is used to emphasize the design over.",
                       style: .size90(weight: .regular, theme: .darkGray, alignment: .leading))
                .frame(maxWidth:.infinity , maxHeight: 70)
                .padding(.top , 10)
                .padding(.bottom, 10)
                .padding(.leading , 20)
                .padding(.trailing, 20)
                .lineLimit(2)
            }
            .background(Color.lightBlue)
            .padding(.top , Spacing.spacing3x)
        }
        
        .background(Color.yellow)
        .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing5x))
    }
    
    private func contactButtons() -> some View {
        HStack {
            Button(action: {
                // Handle button tap
                print("Button tapped")
            })
            {
                
                Image(systemName: "phone.fill")
                    .frame(width: Sizing.sizing10x, height: Sizing.sizing10x)
                    .foregroundColor(.darkGray)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing5x))
                
            }
            
            Button(action: {
                // Handle button tap
                print("Button tapped")
            }) {
                
                Image(systemName: "message.fill")
                    .frame(width: Sizing.sizing10x, height: Sizing.sizing10x)
                    .foregroundColor(.darkGray)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing5x))
                
            }
        }
        
    }
}

private extension Sizing {
    static let profileImageSize: CGFloat = (Sizing.sizing4x + Sizing.sizing0xHalf) * Sizing.sizing1x
}


#Preview {
    TeacherProfileCard()
        .environment(\.mainWindowSize, UIScreen.main.bounds.size)
        .padding(72)
}
