import SwiftUI
import SCTokens
import SCComponents

struct ContentView: View {

    @State private var path: NavigationPath = .init()
    private let viewModel: AllContentViewModel
    
    init() {
        self.viewModel = AllContentViewModel()
    }
    
    var body: some View {
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
        
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            SDText("School Diary", style: .size100(weight: .light, theme: .standard))
//            SDText("School Diary", style: .size100(weight: .regular, theme: .negative))
//            SDText("School Diary", style: .size100(weight: .medium, theme: .positive))
//            SDText("School Diary", style: .size100(weight: .semiBold, theme: .bright))
//            SDText("School Diary", style: .size100(weight: .bold, theme: .secondry))
//
//            SDImage(.remote(url: "https://picsum.photos/seed/picsum/200/300"))
//                .frame(width: 128, height: 128)
//                .clipShape(.rect(cornerRadius: 25))
//            
//            SDTextField(text: $username, placeholder: "Email", errorMessage: "Enter a valid email", isSecure: false)
//            SDTextField(text: $usernameEmpty, placeholder: "Email", errorMessage: "Enter a valid email", isSecure: false)
            
//            StudentBasicProfileCardView()
//        }
    }
}

#Preview {
    ContentView()
}
