import SwiftUI
import SCComponents
import SCTokens

struct BlogCardView: View {
    
    // variables/properties
    
    // your view model
    @ObservedObject var viewModel: BlogCardViewModel = BlogCardViewModel()
    
    init() {
        setupUI()
        initViewModel()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            SDImage(.remote(url: "https://picsum.photos/id/103/600/900", contentMode: .fill))
                .frame(height: 140)
                .padding(.bottom, Spacing.spacing3x)
                .clipped()
                
            SDText("The Power of Fiction and Fiction and N...", style: .size200(weight: .semiBold, theme: .darkGray))
                .padding(.bottom, -Spacing.spacing0xHalf)
                .lineLimit(1)
                
            
            SDText("When asked about her reading preferences, Rishika enthusiastically...", style: .size100(weight: .regular, theme: .darkGray))
                .lineLimit(2)
                
    
            HStack(content: {
                SDButton("1 day ago", buttonType: .noStyle(.size75(weight: .regular, theme: .secondry)), spacing: Spacing.spacing1xHalf, icon: .local(resource: Icons.ic_notification.value, iconSize: .extraSmall, contentMode: .fit)) {}
                
                SDButton("8 min read", buttonType: .noStyle(.size75(weight: .regular, theme: .secondry)), spacing: Spacing.spacing1xHalf, icon: .local(resource: Icons.ic_notification.value, iconSize: .extraSmall, contentMode: .fit)) {}
            })
            .padding(.leading, -Spacing.spacing2x)
            .padding(.top, -Spacing.spacing2xHalf)
        }
        .padding(Sizing.sizing4x)
        .background(Color.white)
        .border(.init(cornerRadius: Sizing.sizing4x, color: .grayStroke.opacity(0.3), width: 1.0))
        .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing4x))
    }
    
    private func setupUI() {
        // setup for the UI
    }
    
    private func initViewModel() {
        // setup for the ViewModel
        // viewModel.fetchData()
    }
}

#Preview {
    BlogCardView().padding()
}
