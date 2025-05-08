import SwiftUI
import SCTokens
import SCComponents

public struct HomeworkCard: View {
    
    // variables/properties
    
    // your view model
    private let viewModel: UpcomingCardViewModel
    
    public init(viewModel: UpcomingCardViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, content: {
                SDText("Chemistry", style: .size100(weight: .semiBold, theme: .primary, alignment: .leading), icon: .local(resource: Icons.ic_Syllabus.value, iconSize: .large, contentMode: .fit, placement: .left))
                    .padding(.bottom, Spacing.spacing1x)
                
                SDText("Praveen Kumar", style: .size100(weight: .semiBold, theme: .primary, alignment: .leading), icon: .local(resource: Icons.ic_Teachers.value, iconSize: .large, contentMode: .fit, placement: .left))
                    .padding(.bottom, Spacing.spacing1x)
                
                dueSubView
                workDeatilView
            })
            .padding(.top, Spacing.spacing1x)
        }
        .padding(Sizing.sizing4x)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing4x))
        .shadow(SDElevation.defaultGrayElevation)
    }
    
    private var dueSubView: some View {
        HStack {
            HStack(content: {
                SDText("Due:", style: .size90(weight: .bold, theme: .primary, alignment: .leading), icon: .local(resource: Icons.ic_Attendance.value, iconSize: .large, contentMode: .fit, placement: .left))
                    .padding(.trailing, -Spacing.spacing0xHalf)
                SDText("Monday", style: .size90(weight: .medium, theme: .primary, alignment: .leading))
            })
            .padding(.trailing, Spacing.spacing1x)
            
            HStack(content: {
                SDText("Sub:", style: .size90(weight: .bold, theme: .primary, alignment: .leading), icon: .local(resource: Icons.ic_Attendance.value, iconSize: .large, contentMode: .fit, placement: .left))
                    .padding(.trailing, -Spacing.spacing0xHalf)
                SDText("Wednesday", style: .size90(weight: .medium, theme: .primary, alignment: .leading))
            })
        }
        .padding(.bottom, Spacing.spacing1x)
    }
    
    private var workDeatilView: some View {
        HStack {
            Rectangle().fill(Color.royalBlue).frame(width: Sizing.sizing0xQuarter, height: Sizing.sizing8x)
            SDText("An army contingent of 616 members is to march behind members is to march behind and army band of 32 members in a...", style: .size90(weight: .medium, theme: .darkGray, alignment: .leading))
                .lineLimit(2)
        }
    }
}

extension HomeworkCard: HasExamples {
    static var examples: [Example] {
        [Example("LearnWithFunCardView", width: 300, height: 300) {
            LearnWithFunCardView()
        }]
    }
}

#Preview {
    VStack(content: {
        HomeworkCard(viewModel: UpcomingCardViewModel(isShadow: true))
    })
    .padding()
}
