import Foundation
import SCTokens

struct AttendanceCalCardHeader: Codable {
    let title1: String
    let title2: String
    let title3: String
}

struct AttendanceCalCardItem: Codable {
    let title1: String
    let title2: String
    let icon: Icons?
}
