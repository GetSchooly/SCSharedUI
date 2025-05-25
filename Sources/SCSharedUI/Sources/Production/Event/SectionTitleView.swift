
import SwiftUI
import SCTokens
import SCComponents

public struct SectionTitleView: View {
    public init () {
        Font.loadMyFonts
        setUp()
        initView()
    }
    
    private func setUp() {
        
    }
    
    private func initView() {
        
    }
    
    public  var body: some View {
        
        HStack {
            SDText("Upcoming", style: .size200(weight: .semiBold, theme: .primary, alignment: .leading))
                .padding(.leading , 10)
            Spacer()
     
            SDButton("See All", buttonType: .noStyle(.size200(weight: .semiBold, theme: .primary, alignment: .trailing)), onTapAction: {
                print("Tapped See All::::")
            })
                Image(systemName: "chevron.right")
                .padding(.trailing, 10)
                   
         
            
        }
        
    }
}

#Preview {
    SectionTitleView()
}
