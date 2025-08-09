import Foundation

class BlogCardViewModel: ObservableObject {
    private let blog: TodayReadModel
    init(blog: TodayReadModel) {
        self.blog = blog
    }
    
    var imageURL: String {
        blog.posterImage
    }
    
    var title: String {
        blog.title
    }
    
    var subtitle: String {
        blog.description
    }
    
    var date: String {
        blog.formattedDate
    }
    var readingTime: String {
        blog.readingTime
    }
    
    
}
