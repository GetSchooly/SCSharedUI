import SwiftUI
import SCComponents
import SCTokens

public struct StudentOptionsView: View {
    
    // variables/properties
    private let onTapOption: ((StudentOptionsModel) -> Void)?
    @State var scrollContentHeight: CGFloat = 0
    
    // your view model
    @StateObject var viewModel: StudentOptionsViewModel = StudentOptionsViewModel()
    
    public init(onTapOption: @escaping (StudentOptionsModel) -> Void) {
        self.onTapOption = onTapOption
        setupUI()
        initViewModel()
        Font.loadMyFonts
    }
    
    public var body: some View {
        setupOptions()
            .padding(.vertical, Spacing.spacing5x)
            .padding(.horizontal, Spacing.spacing4x)
            .background(Color.white)
            .clipShape(.rect(cornerRadius: Sizing.sizing5x))
            .shadow(.defaultGrayElevation)
    }
    
    private func setupUI() {
        // setup for the UI
    }
    
    private func initViewModel() {
        // setup for the ViewModel
        // viewModel.fetchData()
    }
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private func setupOptions() -> some View {
        ScrollView {
            LazyVGrid(columns: columns, alignment: .center, spacing: Spacing.spacing5x) {
                ForEach(viewModel.studentOptions, id: \.self) { item in
                    OptionView(item: item)
                        .onTapGesture {
                            onTapOption?(item)
                        }
                }
            }
            .getContentSize { size in
                scrollContentHeight = size.height
            }
        }
        .scrollDisabled(true)
        .scrollIndicators(.never)
        .frame(height: scrollContentHeight)
    }
}

private struct OptionView: View {

    let item: StudentOptionsModel
    
    var body: some View {
        VStack(alignment: .center, spacing: Spacing.spacing1x) {
            SDImage(.local(resource: item.icon, iconSize: .XXLarge))
            SDText(item.title, style: .size75(weight: .semiBold, theme: .secondry, alignment: .leading))
        }
        .frame(minWidth:Sizing.sizing14x)
        .padding(Spacing.spacing4x)
        .background(Color.lightGray.opacity(0.1))
        .clipShape(.rect(cornerRadius: Sizing.sizing3x))
    }
}

extension StudentOptionsView: HasExamples {
    static var examples: [Example] {
        [Example("StudentOptionsView", width: 300, height: 300) {
            StudentOptionsView { _ in }
        }]
    }
}

#Preview {
    StudentOptionsView { _ in }
        .padding()
}
