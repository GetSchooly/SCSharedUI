import SwiftUI

public class BlogAndActivityDetailModel: ObservableObject {
   let activity: DoActivitiesModel
    let isTodayRead: Bool
    let todayRead: TodayReadModel
    
   public init(activity: DoActivitiesModel, todayRead: TodayReadModel , isTodayRead: Bool = false) {
       self.activity = activity
       self.isTodayRead = isTodayRead
       self.todayRead = todayRead
    }
    
    var imageURL: String {
        isTodayRead ? todayRead.posterImage : activity.image
    }
    
    var title: String {
        isTodayRead ? todayRead.title : activity.title
    }
    
    var subtitle: String {
        isTodayRead ? todayRead.description : activity.description ?? ""
    }
    
    var readingTime: String {
        isTodayRead ? todayRead.readingTime : activity.ageGroup ?? ""
    }
    
    var ageGroup:String {
        isTodayRead ? "" : activity.ageGroup ?? ""
    }
    
    var material:[String] {
        isTodayRead ? [""] : activity.materials
    }
    
    var steps: [String] {
        isTodayRead ? [""] : activity.steps
    }
    
    var difficulty: String {
        isTodayRead ? "" :  activity.difficulty.rawValue
    }
}

extension BlogAndActivityDetailModel {
    var mockActivity: DoActivitiesModel {
        DoActivitiesModel.mockActivity
    }
}
