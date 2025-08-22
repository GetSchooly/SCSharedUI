import SwiftUI
import SCTokens
import SCComponents

public struct ProfileSettingsButtons: View {
    private var tabName: String
    private var tabImage: Icons
    private var textTheme: SDTextTheme
    private var onTap: (() -> Void)?

    public init(
        tabNameString: String,
        tabImageString: Icons,
        textTheme: SDTextTheme = .primary,
        onTap: (() -> Void)? = nil
    ) {
        self.tabName = tabNameString
        self.tabImage = tabImageString
        self.textTheme = textTheme
        self.onTap = onTap
    }

    public var body: some View {
        tabButton
    }

    private var tabButton: some View {
        HStack {
            SDImage(.local(resource: tabImage.value, iconSize: .large, contentMode: .fit))

            SDText(tabName,
                   style: .size100(weight: .regular, theme: textTheme, alignment: .leading))
            .padding(.horizontal, Spacing.spacing2x)

            Spacer()
            SDImage(.local(resource: Icons.ic_NextArrow.rawValue, iconSize: .large, contentMode: .fit))
        }
        .padding(.horizontal, Spacing.spacing4x)
        .frame(height: Sizing.sizing14x)
        .background(Color.appwhite)
        .onTapGesture {
            onTap?()
        }
    }
}

#Preview {
    ProfileSettingsButtons(tabNameString: "Name", tabImageString: Icons.ic_Support)
}
