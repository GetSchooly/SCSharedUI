import Foundation

public class StudentProfileCardViewModel: ObservableObject {
    @Published var student: StudentData?
    
    public init(student: StudentData) {
        self.student = student
    }
    
    var profileImageURL: String {
        student?.studentProfileImage ?? ""
    }
    
    var studentName: String {
        student?.studentName ?? ""
    }
    
    var classAndRollNumber: String {
        "\("XI-B") | Roll no: \("04")"
    }
    
    var profileStatus: String {
        "Connected"
    }
}
