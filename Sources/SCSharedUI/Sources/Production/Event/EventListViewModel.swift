
import SwiftUI

public class EventListViewModel: ObservableObject {
    var eventList: [EventDetailModel] = []
    
    static let sample: EventDetailModel = EventDetailModel(name: "Independance Day", date: "15th August", time: "07:15 AM", view: "36.45K", image: "https://picsum.photos/id/103/200/200")
    
    public init() {
        self.eventList = [ EventDetailModel(name: "Deepawali", date: "20th Nov 2019", time: "07:15 PM", view: "36.45K", image: "https://picsum.photos/id/103/200/200"),
                             EventDetailModel(name: "Vijay Dashmi", date: "15th Oct 20020", time: "07:15 AM", view: "36.45K", image: "https://picsum.photos/id/103/200/200"),
                             EventDetailModel(name: "Independance Day", date: "15th August", time: "07:15 AM", view: "36.45K", image: "https://picsum.photos/id/103/200/200"),
                             EventDetailModel(name: "Independance Day", date: "15th August", time: "07:15 AM", view: "36.45K", image: "https://picsum.photos/id/103/200/200"),
                             EventDetailModel(name: "Independance Day", date: "15th August", time: "07:15 AM", view: "36.45K", image: "https://picsum.photos/id/103/200/200"),
                             EventDetailModel(name: "Independance Day", date: "15th August", time: "07:15 AM", view: "36.45K", image: "https://picsum.photos/id/103/200/200"),
                             EventDetailModel(name: "Independance Day", date: "15th August", time: "07:15 AM", view: "36.45K", image: "https://picsum.photos/id/103/200/200"),
                             EventDetailModel(name: "Independance Day", date: "15th August", time: "07:15 AM", view: "36.45K", image: "https://picsum.photos/id/103/200/200"),
                             EventDetailModel(name: "Independance Day", date: "15th August", time: "07:15 AM", view: "36.45K", image: "https://picsum.photos/id/103/200/200"),
                             EventDetailModel(name: "Independance Day", date: "15th August", time: "07:15 AM", view: "36.45K", image: "https://picsum.photos/id/103/200/200")]
                             
    }
}


