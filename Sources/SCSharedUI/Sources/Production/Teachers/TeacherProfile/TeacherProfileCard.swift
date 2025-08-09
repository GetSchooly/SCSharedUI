import SwiftUI
import SCComponents
import SCTokens

enum ContactOption {
    case call
    case chat
}

struct TeacherProfileCard: View {
    let teacher: TeacherProfile
    let teacherType: String?
    let onTap: (ContactOption, String) -> Void
    
    var body: some View {
        VStack {
            VStack {
                SDImage(.remote(url: teacher.teacherProfileImage ?? "", contentMode: .fill))
                    .frame(width: Sizing.profileImageSize - Spacing.spacing2x, height: Sizing.profileImageSize - Spacing.spacing2x)
                    .background(Color.royalBlue)
                    .clipShape(.circle)
            }
            .frame(width: Sizing.profileImageSize, height: Sizing.profileImageSize)
            .background(Color.royalBlue10)
            .clipShape(.circle)
            .padding(.top, Spacing.spacing5x)

            SDText(teacher.teacherName, style: .size100(weight: .bold, theme: .primary, alignment: .leading))
                .padding(.top, Spacing.spacing2x)
                .padding(.horizontal, Spacing.spacing2x)
                .lineLimit(1)
                .frame(maxWidth: .infinity)

            SDText(
                "\(teacherType ?? teacher.subjectName) Teacher",
                style: .size90(
                    weight: .medium,
                    theme: .primary,
                    alignment: .leading
                )
            )
            .padding(.top, Spacing.spacing0x)
            .padding(.horizontal, Spacing.spacing2x)
            .lineLimit(1)
            .frame(maxWidth: .infinity)

            contactButtons()
                .padding(.top, Spacing.spacing1x)

            VStack {
                SDText("Lorem ipsum is used to emphasize the design over.Lorem ipsum is used to emphasize the design over.Lorem ipsum is used to emphasize the design over.Lorem ipsum is used to emphasize the design over.",
                       style: .size90(weight: .medium, theme: .secondry, alignment: .leading))
                .padding(.top , Spacing.spacing3x)
                .padding(.bottom, Spacing.spacing3x)
                .padding(.leading , Spacing.spacing3x)
                .padding(.trailing, Spacing.spacing3x)
                .lineLimit(3)
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
            contactButtonUI(.ic_call) {
                onTap(.call, teacher.contactNumber ?? "+91-1234567890")
            }
            .disabled(teacher.contactNumber == nil)
            .opacity(teacher.contactNumber == nil ? 0.advanced(by: 0.2) : 1)

            contactButtonUI(.ic_chat) {
                onTap(.chat, "+91-1234567890")
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
        .background(Color.lightBlue)
        .clipShape(.circle)
    }
}

private extension Sizing {
    static let profileImageSize: CGFloat = (Sizing.sizing4x + Sizing.sizing0xHalf) * Sizing.sizing1x
}

extension TeachersListView: HasExamples {
    static var examples: [Example] {
        [Example("TeachersListView One card", width: 240, height: 220) {
            TeacherProfileCard(
                teacher: TeacherListModel.mockATeacher,
                teacherType: "Class",
                onTap: { _, _ in
                }
            )
        },
         Example("TeachersListView Two card", width: 300, height: 150) {
            HStack(spacing: 16) {
                TeacherProfileCard(
                    teacher: TeacherListModel.mockATeacher,
                    teacherType: "Class",
                    onTap: { _, _ in
                    }
                )
                TeacherProfileCard(
                    teacher: TeacherListModel.mockATeacher,
                    teacherType: nil,
                    onTap: { _, _ in
                    }
                )
            }
         }]
    }
}

#Preview {
    TeacherProfileCard(
        teacher: TeacherListModel.mockATeacher,
        teacherType: "Class",
        onTap: { _, _ in
        }
    )
    .padding(.horizontal, 72)
    .environment(\.mainWindowSize, UIScreen.main.bounds.size)
    .padding(16)
}
