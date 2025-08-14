import SwiftUI
import SCComponents
import SCTokens

struct BlogCardView: View {
    
    // variables/properties
    
    // your view model
    @ObservedObject var viewModel: BlogCardViewModel
    
    public init(_ viewModel: BlogCardViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            SDImage(.remote(url: viewModel.imageURL, contentMode: .fill))
                .frame(height: 140)
                .padding(.bottom, Spacing.spacing3x)
                .clipped()
                
            SDText(viewModel.title, style: .size200(weight: .semiBold, theme: .darkGray))
                .padding(.bottom, -Spacing.spacing0xHalf)
                .lineLimit(1)
                
            
            SDText(viewModel.subtitle, style: .size100(weight: .regular, theme: .darkGray))
                .lineLimit(2)
                
    
            HStack(content: {
                SDButton(viewModel.date, buttonType: .noStyle(.size75(weight: .regular, theme: .secondry)), spacing: Spacing.spacing1xHalf, icon: .local(resource: Icons.ic_Rectangle.value, iconSize: .extraSmall, contentMode: .fit)) {}
                
                SDButton("\(viewModel.readingTime) min read", buttonType: .noStyle(.size75(weight: .regular, theme: .secondry)), spacing: Spacing.spacing1xHalf, icon: .local(resource: Icons.ic_Rectangle.value, iconSize: .extraSmall, contentMode: .fit)) {}
            })
            .padding(.leading, -Spacing.spacing2x)
            .padding(.top, -Spacing.spacing2xHalf)
        }
        .padding(Sizing.sizing4x)
        .background(Color.white)
        .border(.init(cornerRadius: Sizing.sizing4x, color: .grayStroke.opacity(0.3), width: 1.0))
        .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing4x))
    }
}

#Preview {
    BlogCardView(BlogCardViewModel(blog: TodayReadModel.mockTodayRead)).padding()
}
