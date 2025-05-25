import Foundation

public struct InboxCardModel {
    let text, name: String
    private let profileImageUrl: String?
    let username: String
    let timeAgo: String
    
    public init(text: String, name: String, profileImageUrl: String?, username: String, timeAgo: String) {
        self.text = text
        self.name = name
        self.profileImageUrl = profileImageUrl
        self.username = username
        self.timeAgo = timeAgo
    }
    
    var userProfileImageUrl: String {
        return profileImageUrl ?? "https://picsum.photos/id/103/200/200"
    }
}
