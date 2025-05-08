import Foundation

public class UpcomingCardViewModel: ObservableObject {
    
    private var isShadow: Bool = true
    
    // MARK:- Initialize
    init(isShadow: Bool) {
        // Do something
        self.isShadow = isShadow
    }
    
    // MARK: - Fetching functions
    func fetchData() {
        // Do something
    }
}
