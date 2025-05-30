

import SwiftUI
import SCTokens
import SCComponents

public struct ProfileSettingsButtons: View {
    private var tabName: String
    private var tabImage: Icons
    private var textTheme: SDTextTheme
   
    public init(tabNameString: String, tabImageString: Icons, textTheme: SDTextTheme = .primary) {
        self.tabName = tabNameString
        self.tabImage = tabImageString
        self.textTheme = textTheme
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
    }
      
    
}

#Preview {
    ProfileSettingsButtons(tabNameString: "Name", tabImageString: Icons.ic_Support)
        
}
