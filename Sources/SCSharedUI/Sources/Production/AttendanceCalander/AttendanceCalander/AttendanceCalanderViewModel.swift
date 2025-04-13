import Foundation

public class AttendanceCalanderViewModel: ObservableObject {
    
    private(set) var attendanceStatus: [AttendanceStatus] = []
    
    // MARK:- Initialize
    public init() {
        // Do something
        setupAttendanceStatus()
    }
    
    // MARK: - Fetching functions
    func fetchData() {
        // Do something
    }
    
    private func setupAttendanceStatus() {
        attendanceStatus = AttendanceStatus.allCases
    }
}
