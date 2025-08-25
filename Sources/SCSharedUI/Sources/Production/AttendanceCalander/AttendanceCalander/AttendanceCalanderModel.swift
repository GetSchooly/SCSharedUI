import Foundation
import Combine

struct AttendanceCalanderModel: Codable {
    let studentAttendance: [StudentAttendance]
}

struct StudentAttendance: Codable {
    let isPresent: AttendanceStatus
    let markAttendance, day: String
}

struct CalendarDayModel: Codable {
    let day: String
    let date: String
    var status: AttendanceStatus = .none
}

protocol AttendanceCalanderServiceProtocol {
    func fetchStudentAttendance(studentId: Int, month: Int, year: Int) -> AnyPublisher<ResponseModel<AttendanceCalanderModel>, Error>
}

class AttendanceCalanderService : AttendanceCalanderServiceProtocol {
    let apiClient = URLSessionAPIClient()

    func fetchStudentAttendance(studentId: Int, month: Int, year: Int) -> AnyPublisher<ResponseModel<AttendanceCalanderModel>, any Error> {
        let endPoint = StudentProfileEndPoint.getStudentAttandance(studentId: studentId, month: month, year: year )
        return apiClient.request(endPoint)
    }
}

// MARK: - Mock
extension AttendanceCalanderModel {
    static let mockAttendance = AttendanceCalanderModel(
        studentAttendance: [
            StudentAttendance(
                isPresent: .notMarked,
                markAttendance: "2025-08-01",
                day: "Friday"
            ),
            StudentAttendance(
                isPresent: .absent,
                markAttendance: "2025-08-02",
                day: "Saturday"
            ),
            StudentAttendance(
                isPresent: .none,
                markAttendance: "2025-08-03",
                day: "Sunday"
            ),
            StudentAttendance(
                isPresent: .present,
                markAttendance: "2025-08-04",
                day: "Monday"
            ),
            StudentAttendance(
                isPresent: .present,
                markAttendance: "2025-08-05",
                day: "Tuesday"
            ),
            StudentAttendance(
                isPresent: .present,
                markAttendance: "2025-08-06",
                day: "Wednesday"
            ),
            StudentAttendance(
                isPresent: .present,
                markAttendance: "2025-08-07",
                day: "Thursday"
            ),
            StudentAttendance(
                isPresent: .notMarked,
                markAttendance: "2025-08-08",
                day: "Friday"
            ),
            StudentAttendance(
                isPresent: .none,
                markAttendance: "2025-08-09",
                day: "Saturday"
            ),
            StudentAttendance(
                isPresent: .none,
                markAttendance: "2025-08-10",
                day: "Sunday"
            ),
            StudentAttendance(
                isPresent: .upcoming,
                markAttendance: "2025-08-11",
                day: "Sunday"
            ),
            StudentAttendance(
                isPresent: .upcoming,
                markAttendance: "2025-08-12",
                day: "Sunday"
            ),
        ]
    )
}
