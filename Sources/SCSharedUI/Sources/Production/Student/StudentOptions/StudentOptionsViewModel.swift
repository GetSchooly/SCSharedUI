import Foundation
import SCTokens

class StudentOptionsViewModel: ObservableObject {
    
    @Published private(set) var studentOptions: [StudentOptionsModel] = []
    
    // MARK:- Initialize
    init() {
        // Do something
        fetchData()
    }
    
    // MARK: - Fetching functions
    func fetchData() {
        // Do something
        studentOptions = [
            StudentOptionsModel(id: .teachers, title: "Teachers", icon: Icons.ic_Teachers.value, isSelected: false),
            StudentOptionsModel(id: .attendance, title: "Attendance", icon: Icons.ic_Attendance.value, isSelected: false),
            StudentOptionsModel(id: .timeTable, title: "Time Table", icon: Icons.ic_timeTable.value, isSelected: false),
            
            StudentOptionsModel(id: .syllabus, title: "Syllabus", icon: Icons.ic_Syllabus.value, isSelected: false),
            StudentOptionsModel(id: .homework, title: "Homework", icon: Icons.ic_Homework.value, isSelected: false),
            StudentOptionsModel(id: .exams, title: "Exams", icon: Icons.ic_Exams.value, isSelected: false),
        
            StudentOptionsModel(id: .results, title: "Results", icon: Icons.ic_result.value, isSelected: false),
            StudentOptionsModel(id: .fees, title: "Fees", icon: Icons.ic_Fees.value, isSelected: false),
            StudentOptionsModel(id: .events, title: "Events", icon: Icons.ic_Events.value, isSelected: false),
        ]
    }
}
