import SwiftUI
import SCTokens
import SCComponents

public struct ContentView: View {

    @State private var path: NavigationPath = .init()
    private let viewModel: AllContentViewModel
    
    public init() {
        self.viewModel = AllContentViewModel()
    }
    
    public var body: some View {
        NavigationStack(path: $path) {
            List(viewModel.items, id: \.self) { item in
                SDButton(item.name, buttonType: .noStyle(), spacing: Sizing.sizing1x) {
                    path.append(item)
                }
            }
            .navigationDestination(for: ContentModel.self, destination: { item in
                SubContentView(title: item.name, model: item, path: $path)
            })
            .navigationTitle("All UI Components")
        }
    }
}

#Preview {
    ContentView()
}
