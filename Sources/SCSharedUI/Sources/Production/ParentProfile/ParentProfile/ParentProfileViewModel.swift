import Foundation
import SCTokens

class ParentProfileViewModel: ObservableObject {
    
    var tabSettingsItems: [ParentProfileModel] = [
        ParentProfileModel(title: "Subscription", image: Icons.ic_Subscribe),
        ParentProfileModel(title: "Language", image: Icons.ic_lang)
    ]
    
    
    var tabOtherItems: [ParentProfileModel] = [
        ParentProfileModel(title: "Support/FAQ", image: Icons.ic_Support),
        ParentProfileModel(title: "Logout", image: Icons.ic_Logout)
    ]
    
    // MARK:- Initialize
    init() {
        // Do something
        
    }
    
    // MARK: - Fetching functions
    func fetchData() {
        // Do something
    }
}
