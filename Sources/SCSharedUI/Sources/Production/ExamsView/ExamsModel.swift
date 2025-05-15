import Foundation

struct ExamsModel: Codable , Identifiable , Hashable{
    var subject: String = ""
    let id: Int?
    let date:String?
    let endTime:String?
    let startTime:String?
    let mark:String?
    let passingMark:String?
}
