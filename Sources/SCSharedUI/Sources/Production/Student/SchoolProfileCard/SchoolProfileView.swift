import SwiftUI
import SCTokens
import SCComponents

public struct SchoolProfileView: View {
    
    // variables/properties
    private let onTap: (() -> Void)?
    
    @Environment(\.mainWindowSize) var mainWindowSize
    
    // your view model
    @StateObject var viewModel: SchoolProfileViewModel = SchoolProfileViewModel()
    
    public init(onTap: (() -> Void)? = nil) {
        self.onTap = onTap
        setupUI()
        initViewModel()
        Font.loadMyFonts
    }
    
    public var body: some View {
        profileView
        .padding(Spacing.spacing4x)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: Sizing.sizing4x))
        .shadow(SDElevation.defaultGrayElevation)
        .onTapGesture {
            onTap?()
        }
    }
    
    private var profileView: some View {
        VStack(alignment: .center) {
            HStack(alignment: .top) {
                ZStack(alignment: .bottomTrailing, content: {
                    profileImage
                    infoImage
                })
            }
            basicInfo
        }
        .padding(Spacing.spacing2x)
        .frame(maxWidth: mainWindowSize.width * Constants.widthPercentage, maxHeight: Constants.viewHeight)
    }
    
    private var profileImage: some View {
        SDImage(.remote(url: "https://picsum.photos/seed/picsum/200/300", placeholder: Icons.ic_school.value))
            .frame(width: Constants.profileImageSize, height: Constants.profileImageSize, alignment: .center)
            .clipShape(.circle)
            .border(.init(
                cornerRadius: Constants.profileImageSize/Sizing.sizing0xHalf,
                color: .royalBlue10,
                width: Sizing.sizing2x)
            )
    }
    
    private var infoImage: some View {
        SDImage(.local(resource: Icons.ic_info.value, iconSize: .large, contentMode: .fill))
            .background(Color.white)
            .clipShape(.circle)
            .border(.init(
                cornerRadius: Sizing.sizing5x/Sizing.sizing0xHalf,
                color: .royalBlue10,
                width: Sizing.sizing0xHalf)
            )
    }
    
    private var basicInfo: some View {
        VStack(alignment: .center) {
            SDText("Delhi Public School Public School", style: .size100(weight: .semiBold, theme: .primary))
            HStack {
                Color.royalBlue.frame(width: Sizing.sizing2x, height: Sizing.sizing2x)
                    .clipShape(.circle)
                    .border(.init(
                        cornerRadius: Sizing.sizing2x/Sizing.sizing0xHalf,
                        color: .royalBlue10,
                        width: Sizing.sizing2x)
                    )
                SDText("2 new updates", style: .size90(weight: .regular, theme: .royalBlue))
            }
        }
    }
    
    private func setupUI() {
        // setup for the UI
    }
    
    private func initViewModel() {
        // setup for the ViewModel
        // viewModel.fetchData()
    }
}

private struct Constants {
    static let profileImageSize: CGFloat = 60.0
    static let widthPercentage: CGFloat = 0.45
    static let viewHeight: CGFloat = 125
}

extension SchoolProfileView: HasExamples {
    static var examples: [Example] {
        [Example("SchoolProfileView", width: 200, height: 200) {
            SchoolProfileView()
        }]
    }
}

#Preview {
    SchoolProfileView()
        .environment(\.mainWindowSize, .init(width: 300, height: 400))
        .frame(width: 200, height: 200)
}
