

import SwiftUI
import SCTokens
import SCComponents

public struct ProfileSettingsButtons: View {
    @State var tabName:String
    @State var tabImage: Icons
   
    public init(tabNameString: String, tabImageString: Icons) {
        self.tabName = tabNameString
        self.tabImage = tabImageString
       

    }
    
    public var body: some View {
        tabButtops
    }
    
    private var tabButtops: some View {
        HStack (){
            
        SDImage(.local(resource: tabImage.value, iconSize: .XXLarge, contentMode: .fit))
                    .frame(width: Sizing.sizing6x , height: Sizing.sizing6x)
                    .padding(.leading ,  Spacing.spacing2xHalf)
               
            SDText(tabName, style: .size100(weight: .regular, theme: .primary, alignment: .leading))
                .frame(height: Sizing.sizing12x)
                .padding(.horizontal , Spacing.spacing2xHalf)
                
                Spacer()
                SDImage(.local(resource: Icons.ic_NextArrow.rawValue, iconSize: .XXLarge, contentMode: .fit, placement: .right))
                    .frame(width: Sizing.sizing6x , height: Sizing.sizing6x)
                    .padding(.trailing ,  Spacing.spacing2xHalf)
                
            }
        
    
    }
      
    
}

#Preview {
    ProfileSettingsButtons(tabNameString: "Name", tabImageString: Icons.ic_Support)
        
}
