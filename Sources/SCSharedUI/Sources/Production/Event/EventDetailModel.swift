

import Foundation

public struct EventDetailModel:Identifiable , Hashable {
    public let id  = UUID()
    let name : String
    let date : String
    let time :String
    let view: String
    let image: String
}
