import SwiftUI
import SCTokens
import SCComponents

struct SubContentView: View {

    @Binding var path: NavigationPath
    private let title: String
    private let model: ContentModel
    
    init(title: String, model: ContentModel, path: Binding<NavigationPath>) {
        self.title = title
        self.model = model
        self._path = path
    }
    
    var body: some View {
        List(model.content, id: \.self) { example in
            SDButton(example.title,
                     buttonType: .noStyle(),
                     spacing: Sizing.sizing1x) {
                path.append(example)
            }
        }
        .navigationDestination(for: Example.self, destination: { example in
            example
        })
        .navigationTitle(title)
    }
    
    @ViewBuilder
    private func setupExample(_ example: Example) -> some View {
        example
    }
}
