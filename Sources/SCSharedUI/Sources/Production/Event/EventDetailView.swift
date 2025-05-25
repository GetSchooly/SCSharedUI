

import SwiftUI
import SCTokens
import SCComponents

public struct EventDetailView: View {
    @State var isCompletedEventView: Bool
    @State var data:EventDetailModel
    
    public init(_ isCompleted:Bool , _ data: EventDetailModel) {
        self.isCompletedEventView = isCompleted
        self.data = data
        setupUI()
        initViewModel()
        Font.loadMyFonts
    }
    
    private func setupUI() {
        // setup for the UI
       
    
    }
    
    private func initViewModel() {
        // setup for the ViewModel
        // viewModel.fetchData()
    }
    
    public var body: some View {
        
            VStack{
                SDImage(.remote(url:
                                    data.image, placeholder: .none, scale: .infinity, contentMode: .fill, placement: .left))
                .frame(maxWidth:.infinity , maxHeight: isCompletedEventView ? 150 : 200)
                .clipped()
                HStack{
                    VStack(alignment: .leading){
                        SDText(data.name, style: isCompletedEventView ? .size75(weight: .regular, theme: .darkGray, alignment: .leading) : .size300(weight: .semiBold, theme: .darkGray, alignment: .leading))
                            .lineLimit(1)
                        
                        SDText(data.date, style: isCompletedEventView ? .size75(weight: .regular, theme: .darkGray, alignment: .leading) : .size200(weight: .regular, theme: .darkGray, alignment: .leading))
                    }
                    Spacer()
                    SDText("\(data.view) Views", style: isCompletedEventView ? .size75(weight: .light, theme: .darkGray, alignment: .leading) : .size200(weight: .regular, theme: .darkGray, alignment: .trailing))
                }
                .padding(Spacing.spacing2x)
            }
            .background(.white)
            .clipShape(RoundedRectangle.init(cornerRadius: 20))
            .padding(10)
             .shadow(.defaultGrayElevation)
               
                
                
        }
    
}

#Preview {
    EventDetailView(false, EventListViewModel.sample)
    
}



struct RoundedCorner: Shape {
    var radius: CGFloat = 25.0
    var corners: UIRectCorner = [.topLeft, .topRight]

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
