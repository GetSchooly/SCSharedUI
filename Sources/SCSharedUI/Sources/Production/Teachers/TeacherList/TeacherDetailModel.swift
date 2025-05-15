import Foundation

struct TeacherDetailModel: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let profile:String
    let subject:String
    let specialization:String
    let contactNumber : String
    let isClassTeacher: Bool
}


