import SwiftUI
import SCComponents
import SCTokens

struct TeacherProfileCard: View {
        
    var body: some View {
        VStack {
            VStack {
                SDImage(.remote(url: "https://picsum.photos/id/103/200/200", contentMode: .fill))
                    .frame(width: Sizing.profileImageSize - Spacing.spacing2x, height: Sizing.profileImageSize - Spacing.spacing2x)
                    .background(Color.royalBlue)
                    .clipShape(.circle)
            }
            .frame(width: Sizing.profileImageSize, height: Sizing.profileImageSize)
            .background(Color.royalBlue10)
            .clipShape(.circle)
            .padding(.top, Spacing.spacing5x)
            
            SDText("Teacher's name", style: .size100(weight: .bold, theme: .primary, alignment: .leading))
                .padding(.top, Spacing.spacing2x)
                .padding(.horizontal, Spacing.spacing2x)
            
            SDText("Class Teacher", style: .size90(weight: .medium, theme: .primary, alignment: .leading))
                .padding(.top, Spacing.spacing0x)
                .padding(.horizontal, Spacing.spacing2x)
            
            contactButtons()
                .padding(.top, Spacing.spacing1x)
            
            VStack {
                SDText("Lorem ipsum is used to emphasize the design over.Lorem ipsum is used to emphasize the design over.Lorem ipsum is used to emphasize the design over.Lorem ipsum is used to emphasize the design over.",
                       style: .size90(weight: .medium, theme: .secondry, alignment: .leading))
                .padding(.top , Spacing.spacing3x)
                .padding(.bottom, Spacing.spacing3x)
                .padding(.leading , Spacing.spacing5x)
                .padding(.trailing, Spacing.spacing5x)
                .lineLimit(2)
            }
            .background(Color.lightBlue)
            .padding(.top , Spacing.spacing3x)
        }
        
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing5x))
        .shadow(.defaultGrayElevation)
    }
    
    private func contactButtons() -> some View {
        HStack(spacing: Spacing.spacing3x) {
            contactButtonUI(.ic_Fees) {
                
            }
            
            contactButtonUI(.ic_Events) {
                
            }
        }
    }
    
    private func contactButtonUI(_ icon: Icons, onTap: @escaping () -> Void) -> some View {
        HStack {
            Spacer()
            SDButton("",
                     buttonType: .noStyle(),
                     icon: .local(resource: icon.value, iconSize: .large))
            {
                onTap()
            }
            .frame(width: Sizing.sizing10x, height: Sizing.sizing10x)
        }
        .frame(width: Sizing.sizing10x, height: Sizing.sizing10x)
        .background(Color.royalBlue10)
        .clipShape(.circle)
    }
}

private extension Sizing {
    static let profileImageSize: CGFloat = (Sizing.sizing4x + Sizing.sizing0xHalf) * Sizing.sizing1x
}

extension TeachersListView: HasExamples {
    static var examples: [Example] {
        [Example("TeachersListView One card", width: 240, height: 220) {
            TeacherProfileCard()
        },
         Example("TeachersListView Two card", width: 300, height: 150) {
            HStack(spacing: 16) {
                TeacherProfileCard()
                TeacherProfileCard()
            }
         }]
    }
}

#Preview {
    TeacherProfileCard()
        .padding(.horizontal, 72)
    .environment(\.mainWindowSize, UIScreen.main.bounds.size)
    .padding(16)
}
