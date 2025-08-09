import Foundation

public class ActivityCardViewModel: ObservableObject {
    private let activity: Activities
    
    // MARK:- Initialize
    public init(activity: Activities) {
        // Do something
        self.activity = activity
    }

    var imageURL: String {
        activity.image
    }
    
    var title: String {
        activity.title
    }
    
    var subtitle: String {
        activity.description
    }
}

extension ActivityCardViewModel {
    var mockActivity: Activities {
        Activities.mockActivity
    }
}
