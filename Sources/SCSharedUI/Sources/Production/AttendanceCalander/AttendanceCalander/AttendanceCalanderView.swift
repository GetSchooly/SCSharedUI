import SwiftUI
import SCComponents
import SCTokens

public struct AttendanceCalanderView: View {
    
    // variables/properties
    @State private var toShowMonthPicker: Bool = false
    // your view model
    @StateObject var viewModel: AttendanceCalanderViewModel = AttendanceCalanderViewModel()
    
    public init() {
        setupUI()
        initViewModel()
    }
    
    public var body: some View {
        VStack(spacing: Spacing.spacing0x) {
            HStack(alignment: .top) {
                topHeaderLeftView
                topHeaderRightView
            }
            .padding(.bottom, Spacing.spacing1x)
            headerView
            wholeMonthView
            footerStatusView
        }
        .sheet(isPresented: $toShowMonthPicker) {
            monthPickerView
        }
    }
    
    private func setupUI() {
        // setup for the UI
    }
    
    private func initViewModel() {
        // setup for the ViewModel
        // viewModel.fetchData()
    }
    
    private var wholeMonthView: some View {
        ScrollView(.vertical) {
            VStack(spacing: Spacing.spacing0x) {
                ForEach(viewModel.calendarData, id: \.date) { attendanceData in
                    let itemViewModel = AttendanceCalCardViewModel(item: AttendanceCalCardItem(
                        title1: attendanceData.day,
                        title2: attendanceData.date,
                        icon: attendanceData.status == .none ? nil : .ic_plus)
                    )
                    AttendanceCalCardView(viewModel: itemViewModel)
                        .opacity(attendanceData.status == .none ? 0.0 : 1)
                }
            }
        }
    }
    
    private var topHeaderLeftView: some View {
        VStack(alignment: .leading, spacing: Spacing.spacing0x) {
            SDText(
                viewModel.currentAssessmentYear,
                style: .size200(weight: .medium, theme: .secondry, alignment: .leading)
            )
            HStack {
                SDButton(
                    viewModel.selectedMonth?.title ?? "",
                    buttonType: .noStyle(.size200(weight: .semiBold, theme: .primary, alignment: .center)),
                    spacing: Spacing.spacing2x,
                    icon: .local(resource: Icons.ic_Fees.value, iconSize: .medium, placement: .right)) {
                        toShowMonthPicker = true
                    }
                    .padding(.leading, -Spacing.spacing2x)
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private var monthPickerView: some View {
        let pickerViewModel = SDPickerViewModel(items: viewModel.months) { selected in
            print(selected)
            self.viewModel.selectedMonth = selected
        }
        SDPickerView(viewModel: pickerViewModel).pickerStyle(.wheel)
    }
    
    private var topHeaderRightView: some View {
        HStack(spacing: Spacing.spacing1x) {
            SDImage(.local(resource: Icons.ic_Fees.value, iconSize: .large))
                .onTapGesture {
                    
                }
            
            SDImage(.local(resource: Icons.ic_Fees.value, iconSize: .large))
                .onTapGesture {
                    
                }
        }
    }
    
    private var headerView: some View {
        let headerViewModel = AttendanceCalCardViewModel(header: AttendanceCalCardHeader(title1: "Day", title2: "Date", title3: "Status"))
        
        return AttendanceCalCardView(viewModel: headerViewModel, height: Sizing.sizing12x)
            .background(Color.royalBlue)
            .border(Color.royalBlue, width: 1)
            .clipShape(
                .rect(topLeadingRadius: CornerRadius.headerCornerRadius,
                      topTrailingRadius: CornerRadius.headerCornerRadius)
            )
    }
    
    private var footerStatusView: some View {
        VStack(spacing: Spacing.spacing5x) {
            footerView1
            footerView2
        }
        .padding(.vertical, Spacing.spacing6x)
    }
  
    private var footerView1: some View {
        HStack(spacing: Spacing.spacing10x) {
            ForEach(0..<3) { index in
                let status = viewModel.attendanceStatus[index]
                AttendanceStatusInfoView(color: status.color , title: status.text)
            }
        }
    }
    
    private var footerView2: some View {
        HStack(spacing: Spacing.spacing10x) {
            ForEach(3..<5) { index in
                let status = viewModel.attendanceStatus[index]
                AttendanceStatusInfoView(color: status.color , title: status.text)
            }
        }
    }
}

private struct AttendanceStatusInfoView: View {
    let color: Color
    let title: String
    
    var body: some View {
        HStack(spacing: Spacing.spacing2x) {
            Rectangle()
                .fill(color)
                .frame(width: Sizing.sizing5x, height: Sizing.sizing5x)
                .clipShape(.circle)
            
            SDText(title, style: .size90(weight: .medium, theme: .primary, alignment: .center))
        }
    }
}

private extension CornerRadius {
    static let headerCornerRadius: CGFloat = Sizing.sizing4x
}

#Preview {
    AttendanceCalanderView()
        .padding()
}
