import SwiftUI
import SCComponents
import SCTokens

public struct AllHomeworkView: View {
    
    // your view model
    @ObservedObject var viewModel: AllHomeworkViewModel
    
    public init(viewModel: AllHomeworkViewModel) {
        Font.loadMyFonts
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            weekCalendarView
            contentView
        }
    }
    
    private var contentView: some View {
        ZStack {
            content
        }
        .padding(.top, Spacing.spacing5x)
        .background(Color.white)
        .clipShape(
            .rect(
                topLeadingRadius: Sizing.sizing5x,
                topTrailingRadius: Sizing.sizing5x,
                style: .continuous
            )
        )
        .ignoresSafeArea(edges: .bottom)
        .shadow(.defaultGrayElevation)
    }
    
    private var content: some View {
        VStack(spacing: Spacing.spacing2x) {
            HStack {
                selectedDay
                Spacer()
            }
            .padding(.top, Spacing.spacing2x)
            .padding(.horizontal, Spacing.spacing5x)
            
            pendingView
        }
    }
    
    private var selectedDay: some View {
        VStack(alignment: .leading, spacing: Spacing.spacing2x) {
            SDText(viewModel.selectedDateMonthYear(),
                style: .size100(
                    weight: .semiBold,
                    theme: .secondry,
                    alignment: .leading
                )
            )
            SDText(viewModel.selectedDateFullDayName(),
                style: .size300(
                    weight: .semiBold,
                    theme: .darkGray,
                    alignment: .leading
                )
            )
        }
    }
    
    @ViewBuilder
    private var weekCalendarView: some View {
        CalendarView(viewModel: viewModel.calendarViewModel)
    }
    
    private var pendingView: some View {
        List {
            ForEach(viewModel.data) { section in
                Section(header: sectionTitleView(section.title)) {
                    ForEach(section.items, id: \.self) { item in
                        HomeworkCard(viewModel: UpcomingCardViewModel(isShadow: false))
                    }
                }
                .listRowSeparator(.hidden)
                .listSectionSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .scrollIndicators(.never)
    }
    
    private func sectionTitleView(_ title: String) -> some View {
        HStack {
            SDText(title,
                   style: .size75(
                    weight: .regular,
                    theme: .primary,
                    alignment: .leading
                   )
            )
            Rectangle()
                .fill(Color.lightGray)
                .frame(height: 0.5)
                .padding(.trailing, Spacing.spacing3x)
        }
    }
}

#Preview {
    AllHomeworkView(viewModel: AllHomeworkViewModel(data: [AllHomeworkModel(title: "ABC", items: ["as", "bs"])]))
}
