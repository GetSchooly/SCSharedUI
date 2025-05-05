import Foundation

struct AttendanceCalanderModel: Codable {
    
}

struct CalendarDayModel: Codable {
    let day: String
    let date: String
    var status: AttendanceStatus = .none
}
