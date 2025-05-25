
import SwiftUI
import SCTokens
import SCComponents

public struct EventListView: View {
    
    @ObservedObject var viewModel: EventListViewModel
    @Environment(\.mainWindowSize) var mainWindowSize
    
    public init(viewModel: EventListViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        eventsView
    }
    
    private var eventsView: some View{
        ScrollView {
       
            VStack() {
                SectionTitleView()
                EventDetailView(false, EventListViewModel.sample)
                    .shadow(.defaultGrayElevation)
                completedEventList
            }
        }
        
    }
    
    private let columns: [GridItem] = [GridItem(.flexible()),
                                       GridItem(.flexible())]
    private var completedEventList: some View {
        VStack(alignment: .leading) {
            SDText("Completed", style:
                    .size200(weight: .semiBold,
                             theme: .primary,
                             alignment: .leading)
            )
            .frame(height: Sizing.sizing5x)
            LazyVGrid(columns: columns){
                ForEach(viewModel.eventList){ event in
                    EventDetailView(true, event)
                        .frame(width: mainWindowSize.width/2)
                        .padding(.trailing, Spacing.spacing1x)
                        .padding(.vertical, Spacing.spacing1x)
                        .shadow(.defaultGrayElevation)
                }
            }
        }
        .padding()
    }
}

#Preview {
    EventListView(viewModel: EventListViewModel())
        .environment(\.mainWindowSize, UIScreen.main.bounds.size)
}
