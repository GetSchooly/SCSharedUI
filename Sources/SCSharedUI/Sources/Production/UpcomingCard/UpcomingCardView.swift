import SwiftUI
import SCComponents
import SCTokens

public struct UpcomingCardView: View {
    
    // variables/properties
    
    // your view model
    @ObservedObject var viewModel: UpcomingCardViewModel = UpcomingCardViewModel()
    
    public init() {
        setupUI()
        initViewModel()
        Font.loadMyFonts
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            SDText("Upcoming", style: .size300(weight: .bold, theme: .standard))
                .lineLimit(1)
                .frame(height: Sizing.sizing6x)
            
            ExamCardView()
        }
        .padding(.horizontal, Sizing.sizing4x)
        .padding(.top, Sizing.sizing2x)
        .padding(.bottom, Sizing.sizing4x)
        .background(Color.red.opacity(0.4))
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
    static let subjectDateViewHeight: CGFloat = 108
}

extension UpcomingCardView: HasExamples {
    static var examples: [Example] {
        [Example("UpcomingCardView", width: 300, height: 300) {
            UpcomingCardView()
        }]
    }
}

#Preview {
    UpcomingCardView()
        .frame(height: 182, alignment: .center)
}
