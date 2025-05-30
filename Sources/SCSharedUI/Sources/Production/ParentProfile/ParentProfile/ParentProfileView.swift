import SwiftUI
import SCComponents
import SCTokens

public struct ParentProfileView: View {
    
    // variables/properties
    @Environment(\.mainWindowSize) var mainWindowSize
    // your view model
    @StateObject var viewModel: ParentProfileViewModel = ParentProfileViewModel()
    
    public init() {
        Font.loadMyFonts
        setupUI()
        initViewModel()
    }
    
    private func setupUI() {
        // setup for the UI
    }
    
    private func initViewModel() {
        // setup for the ViewModel
        // viewModel.fetchData()
    }
    
    public var body: some View {
        parentProfileView
    }
    
    var parentProfileView: some View {
        VStack(alignment: .leading) {
            ParentNameCard()
            
            SDText("Other settings", style: .size200(weight: .semiBold, theme: .primary, alignment: .leading))
                .padding(.top, Spacing.spacing8x)
                .padding(.bottom, Spacing.spacing3x)

            settingList
            otherButtons
                .padding(.top, Spacing.spacing8x)
            Spacer()
        }
        .padding(.horizontal, Spacing.spacing4x)
    }
    
    private var  settingList: some View {
        let items = viewModel.tabSettingsItems
        return VStack {
            ProfileSettingsButtons(tabNameString: items.first!.title , tabImageString: items.first!.image)
            Divider()
            ProfileSettingsButtons(tabNameString: items.last!.title, tabImageString: items.last!.image)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing4x))
        .shadow(.defaultGrayElevation)
    }
    
    private var otherButtons: some View {
        let items = viewModel.tabOtherItems
        return VStack {
            ProfileSettingsButtons(tabNameString: items.first!.title , tabImageString: items.first!.image)
            Divider()
            ProfileSettingsButtons(tabNameString: items.last!.title, tabImageString: items.last!.image, textTheme: .negative)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing4x))
        .shadow(.defaultGrayElevation)
    }
   
}

#Preview {
    ParentProfileView()
        .environment(\.mainWindowSize, UIScreen.main.bounds.size)
}

