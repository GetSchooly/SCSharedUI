import SwiftUI
import SCComponents
import SCTokens

public struct ParentProfileView: View {

    // variables/properties
    @Environment(\.mainWindowSize) var mainWindowSize
    // your view model
    @StateObject var viewModel: ParentProfileViewModel = ParentProfileViewModel()
    @State private var refreshID = UUID()

    public init() {}

    public var body: some View {
        LoadableView(refreshTrigger: refreshID,
                     viewModel: viewModel,
                     publisher: { viewModel.fetchParentProfile() },
                     content:  {
            Group {
                switch viewModel.loadingState.viewLoadingState {
                case .idle, .loading:
                    parentProfileView
                        .shimmer(isLoading: true)

                case .loaded:
                    parentProfileView

                case .failed(let error):
                    LoadingViewHelper.errorView(errorMessage: error.localizedDescription) {
                        refreshID = UUID()
                    }
                }
            }
        })
    }

    var parentProfileView: some View {
        VStack(alignment: .leading) {
            ParentNameCard(parentProfileModel: viewModel.profileModel ?? ParentProfileModel.mockParent)
            
            SDText("Other settings", style: .size200(weight: .semiBold, theme: .primary, alignment: .leading))
                .padding(.top, Spacing.spacing8x)
                .padding(.bottom, Spacing.spacing3x)

            settingList
            otherButtons
                .padding(.top, Spacing.spacing8x)
            Spacer()
        }
        .padding(.horizontal, Spacing.spacing4x)
    }

    private var  settingList: some View {
        let items = viewModel.tabSettingsItems
        return VStack {
            ProfileSettingsButtons(tabNameString: items.first!.title , tabImageString: items.first!.image)
            Divider()
            ProfileSettingsButtons(tabNameString: items.last!.title, tabImageString: items.last!.image)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing4x))
        .shadow(.defaultGrayElevation)
    }

    private var otherButtons: some View {
        let items = viewModel.tabOtherItems
        return VStack {
            ProfileSettingsButtons(tabNameString: items.first!.title , tabImageString: items.first!.image)
            Divider()
            ProfileSettingsButtons(tabNameString: items.last!.title, tabImageString: items.last!.image, textTheme: .negative)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing4x))
        .shadow(.defaultGrayElevation)
    }

}

#Preview {
    ParentProfileView()
        .environment(\.mainWindowSize, UIScreen.main.bounds.size)
}

