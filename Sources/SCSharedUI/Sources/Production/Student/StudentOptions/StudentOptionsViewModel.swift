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
            StudentOptionsModel(id: 0, title: "Teachers", icon: Icons.ic_Teachers.value, isSelected: false),
            StudentOptionsModel(id: 1, title: "Attendance", icon: Icons.ic_Attendance.value, isSelected: false),
            StudentOptionsModel(id: 2, title: "Time Table", icon: Icons.ic_timeTable.value, isSelected: false),
            
            StudentOptionsModel(id: 3, title: "Syllabus", icon: Icons.ic_Syllabus.value, isSelected: false),
            StudentOptionsModel(id: 4, title: "Homework", icon: Icons.ic_Homework.value, isSelected: false),
            StudentOptionsModel(id: 5, title: "Exams", icon: Icons.ic_Exams.value, isSelected: false),
        
            StudentOptionsModel(id: 6, title: "Results", icon: Icons.ic_result.value, isSelected: false),
            StudentOptionsModel(id: 7, title: "Fees", icon: Icons.ic_Fees.value, isSelected: false),
            StudentOptionsModel(id: 8, title: "Events", icon: Icons.ic_Events.value, isSelected: false),
        ]
    }
}
