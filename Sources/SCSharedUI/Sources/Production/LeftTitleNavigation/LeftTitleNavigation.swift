import SwiftUI
import SCComponents
import SCTokens

public struct LeftTitleNavigationView: View {
    private let onSchoolInfoClick: () -> Void
    private let onNotificationAction: () -> Void
    private let onFindChildren: () -> Void

    public init(
        onSchoolInfoClick: @escaping () -> Void,
        onNotificationAction: @escaping () -> Void,
        onFindChildren: @escaping () -> Void
    ) {
        self.onSchoolInfoClick = onSchoolInfoClick
        self.onNotificationAction = onNotificationAction
        self.onFindChildren = onFindChildren
    }

    public var body: some View {
        HStack {
            SDButton(
                "Hello Parent",
                buttonType: .noStyle(
                    .size100(
                        weight: .bold,
                        theme: .primary,
                        alignment: .leading
                    )
                ),
                icon: .local(
                    resource: Icons.ic_schoolInfo.value,
                    iconSize: .XXLarge,
                    contentMode: .fill
                )
            ) {
                onSchoolInfoClick()
            }

            Spacer()

            HStack(spacing: Spacing.spacing1x) {
                SDButton(
                    "",
                    buttonType: .noStyle(),
                    icon: .local(
                        resource: Icons.ic_notification.value,
                        iconSize: .large,
                        contentMode: .fill
                    )
                ) {
                    onNotificationAction()
                }

                SDButton("",
                         buttonType: .noStyle(),
                         icon: .local(
                            resource: Icons.ic_plus.value,
                            iconSize: .large,
                            contentMode: .fill
                         )
                ) {
                    onFindChildren()
                }
            }
        }
        .background(Color.clear)
        .padding(.vertical, Spacing.spacing1x)
    }
}

extension LeftTitleNavigationView: HasExamples {
    static var examples: [Example] {[
        Example("MyChildrenGridView", width: 300, height: 50) {
            LeftTitleNavigationView{} onNotificationAction: {} onFindChildren: {}
        }
    ]}
}

#Preview {
    LeftTitleNavigationView {
        
    } onNotificationAction: {
        
    } onFindChildren: {
        
    }
    .padding()
}
