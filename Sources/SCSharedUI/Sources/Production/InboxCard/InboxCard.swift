import SwiftUI
import SCComponents
import SCTokens

public struct InboxCard: View {
    
    // your view model
    @ObservedObject var viewModel: TodayHomeworkViewModel = TodayHomeworkViewModel()
    
    public init() {
        setupUI()
        initViewModel()
    }
    
    public var body: some View {
        inboxCardView
    }
    
    private var inboxCardView: some View {
        HStack(alignment: .center) {
            SDImage(.remote(url: "https://picsum.photos/id/103/200/200", contentMode: .fit))
                .frame(width: Sizing.sizing12x, height: Sizing.sizing12x)
                .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing6x))
                .padding(.top, Spacing.spacing1x)
            
            messageContentView()
        }
    }
    
    @ViewBuilder
    private func messageContentView() -> some View {
        HStack {
            VStack(alignment: .leading) {
                SDText("Maya Desai", style: .size100(weight: .semiBold, theme: .primary, alignment: .leading))
                    .padding(.bottom, Spacing.spacing0xQuarter)
                SDText("Thank you very much teacher!", style: .size90(weight: .regular, theme: .secondry, alignment: .leading))
            }
            Spacer()
            VStack {
                SDText("09:23 am", style: .size75(weight: .regular, theme: .secondry, alignment: .leading))
               // SDImage(.local(resource: Icons.ic_check.value, iconSize: .large))
                Image(systemName: "5.circle").renderingMode(.template).foregroundStyle(Color.white)
                    .background(Color.royalBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.top, Spacing.spacing0xHalf)
            }
        }
        .padding(.leading, Spacing.spacing3x)
        .padding(.bottom, Spacing.spacing3x)
        .padding(.top, Spacing.spacing3x)
    }
    
    private func setupUI() {
        // setup for the UI
    }
    
    private func initViewModel() {
        // setup for the ViewModel
        // viewModel.fetchData()
    }
}

extension InboxCard: HasExamples {
    static var examples: [Example] {
        [Example("InboxCard", width: 300, height: 300) {
            InboxCard()
        }]
    }
}

#Preview {
    InboxCard().padding()
}
