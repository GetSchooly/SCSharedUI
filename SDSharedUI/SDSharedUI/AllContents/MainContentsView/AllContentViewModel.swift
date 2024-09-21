import Foundation

class AllContentViewModel: ObservableObject {
    
    @Published private(set) var items: [ContentModel] = []
    
    private var allContentTypes: [AllContentViewType] {
        AllContentViewType.allCases
    }
    
    init() {
        self.items = allContentTypes.compactMap({ contentType in
            ContentModel(id: contentType.index, 
                         name: contentType.title,
                         content: contentType.examples)
        })
    }
}
