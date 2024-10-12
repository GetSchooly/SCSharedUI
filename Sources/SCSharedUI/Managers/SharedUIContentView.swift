import SwiftUI

protocol SharedUIContentView {
    associatedtype Content: View
    var contentView: Content { get }
    
    var name: String { get }
}

extension SharedUIContentView {
    var showContent: Bool {
        true
    }
}
