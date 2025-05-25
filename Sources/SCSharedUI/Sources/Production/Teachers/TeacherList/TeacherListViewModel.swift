
import SwiftUI

public class TeacherListViewModel: ObservableObject {
    var teacherList: [TeacherDetailModel] = []
    
    static let sample: TeacherDetailModel = TeacherDetailModel(name: "Sumit Awasthi", profile: "https://picsum.photos/id/103/200/200", subject: "Mathematic", specialization: "In Maths", contactNumber: "9007217345", isClassTeacher: true)
    
    public init() {
        self.teacherList = [ TeacherDetailModel(name: "Sumit Awasthi", profile: "https://picsum.photos/id/103/200/200", subject: "Mathematic", specialization: "In Maths", contactNumber: "9007217345", isClassTeacher: true),
                             TeacherDetailModel(name: "Arpit Yadav", profile: "https://picsum.photos/id/103/200/200", subject: "English", specialization: "In English", contactNumber: "9007217345", isClassTeacher: false),
                             TeacherDetailModel(name: "Mic Joe", profile: "https://picsum.photos/id/103/200/200", subject: "History", specialization: "In History", contactNumber: "9007217345", isClassTeacher: false),
                             TeacherDetailModel(name: "Bryan Long", profile: "https://picsum.photos/id/103/200/200", subject: "Physics", specialization: "In Physics", contactNumber: "9007217345", isClassTeacher: false),
                             TeacherDetailModel(name: "Sumit Awasthi", profile: "https://picsum.photos/id/103/200/200", subject: "Mathematic", specialization: "In Maths", contactNumber: "9007217345", isClassTeacher: false),
                             TeacherDetailModel(name: "Sumit Awasthi", profile: "https://picsum.photos/id/103/200/200", subject: "Mathematic", specialization: "In Maths", contactNumber: "9007217345", isClassTeacher: false),TeacherDetailModel(name: "Sumit Awasthi", profile: "https://picsum.photos/id/103/200/200", subject: "Mathematic", specialization: "In Maths", contactNumber: "9007217345", isClassTeacher: false),TeacherDetailModel(name: "Sumit Awasthi", profile: "https://picsum.photos/id/103/200/200", subject: "Mathematic", specialization: "In Maths", contactNumber: "9007217345", isClassTeacher: false),TeacherDetailModel(name: "Sumit Awasthi", profile: "https://picsum.photos/id/103/200/200", subject: "Mathematic", specialization: "In Maths", contactNumber: "9007217345", isClassTeacher: false)]
                             
    }
}


