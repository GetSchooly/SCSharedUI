import Foundation

public class ActivityCardViewModel: ObservableObject {
    private let activity: DoActivitiesModel
    
    // MARK:- Initialize
    public init(activity: DoActivitiesModel) {
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
        activity.description ?? ""
    }
}

extension ActivityCardViewModel {
    var mockActivity: DoActivitiesModel {
        DoActivitiesModel.mockActivity
    }
}
