import Foundation

public class SponsoredContentViewModel: ObservableObject {
    
    private(set) var adType: SponsoredAdType
    
    // MARK:- Initialize
    public init(adType: SponsoredAdType) {
        // Do something
        self.adType = adType
    }
    
    // MARK: - Fetching functions
    func fetchData() {
        // Do something
    }
}
