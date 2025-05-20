import SwiftUI
import SCComponents
import SCTokens

public struct InboxCard: View {
    
    // your view model
    @ObservedObject var viewModel: InboxCardViewModel
    
    public init(viewModel: InboxCardViewModel) {
        self.viewModel = viewModel
        setupUI()
        initViewModel()
    }
    
    public var body: some View {
        inboxCardView
    }
    
    private var inboxCardView: some View {
        HStack(alignment: .center) {
            SDImage(.remote(url: viewModel.inboxCardModel.userProfileImageUrl
                            , contentMode: .fit))
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
                SDText(viewModel.inboxCardModel.name, style: .size100(weight: .semiBold, theme: .primary, alignment: .leading))
                    .padding(.bottom, Spacing.spacing0xQuarter)
                SDText(viewModel.inboxCardModel.text, style: .size90(weight: .regular, theme: .secondry, alignment: .leading))
            }
            Spacer()
            VStack {
                SDText(viewModel.inboxCardModel.timeAgo, style: .size75(weight: .regular, theme: .secondry, alignment: .leading))
                Image(systemName: "1.circle").renderingMode(.template).foregroundStyle(Color.white)
                    .background(Color.royalBlue)
                    .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing3x))
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
            let viewModel = InboxCardViewModel(inboxCardModel: InboxCardModel(
                text: "Your message here",
                name: "Title here",
                profileImageUrl: "https://picsum.photos/id/103/200/200",
                username: "Title here",
                timeAgo: "20 secs ago"))
            InboxCard(viewModel: viewModel)
        }]
    }
}

#Preview {
    let viewModel = InboxCardViewModel(inboxCardModel: InboxCardModel(
        text: "Your message here",
        name: "Title here",
        profileImageUrl: "https://picsum.photos/id/103/200/200",
        username: "Title here",
        timeAgo: "20 secs ago"))
    InboxCard(viewModel: viewModel).padding()
}
