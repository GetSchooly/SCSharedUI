import SwiftUI
import SCComponents
import SCTokens

public struct AttendanceCalanderView: View {
    @State private var toShowMonthPicker: Bool = false
    @StateObject var viewModel: AttendanceCalanderViewModel = AttendanceCalanderViewModel()
    public let studentId: Int

    public init(studentId: Int) {
        self.studentId = studentId
    }

    public var body: some View {
        Group {
            switch viewModel.loadingState.viewLoadingState {
            case .idle, .loading:
                mainContentView
                    .shimmer(isLoading: true)

            case .loaded:
                mainContentView

            case .failed(let error):
                LoadingViewHelper.errorView(errorMessage: error.localizedDescription) {
                    viewModel.fetchAttendance(studentId: studentId)
                }
            }
        }
        .task {
            viewModel.fetchAttendance(studentId: studentId)
        }
    }

    private var mainContentView: some View {
        VStack(spacing: Spacing.spacing0x) {
            HStack(alignment: .top) {
                topHeaderLeftView
                topHeaderRightView
            }
            .padding(.bottom, Spacing.spacing1x)
            monthSheetView
        }
        .sheet(isPresented: $toShowMonthPicker) {
            monthPickerView
        }
        .shareSheet(
            items: [viewModel.attendaceSheetImage ?? UIImage()],
            isPresented: $viewModel.isShareSheetPresented
        )
    }

    private var monthSheetView: some View {
        VStack {
            headerView
            wholeMonthView
            footerStatusView
        }
    }

    private var wholeMonthView: some View {
        ScrollView(.vertical) {
            VStack(spacing: Spacing.spacing0x) {
                ForEach(viewModel.calendarData, id: \.date) { attendanceData in
                    let itemViewModel = AttendanceCalCardViewModel(item: AttendanceCalCardItem(
                        title1: attendanceData.day,
                        title2: attendanceData.date,
                        icon: attendanceData.status.icon)
                    )
                    AttendanceCalCardView(viewModel: itemViewModel)
                        .opacity(
                            (attendanceData.status == .sunday || attendanceData.status == .upcoming) ? 0.3 : 1
                        )
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
                    viewModel.selectedMonth.title,
                    buttonType: .noStyle(
                        .size200(
                            weight: .semiBold,
                            theme: .primary,
                            alignment: .center
                        )
                    ),
                    spacing: Spacing.spacing2x,
                    icon: .local(
                        resource: Icons.ic_downArrow.value,
                        iconSize: .medium,
                        placement: .right
                    )
                ) {
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
            self.viewModel.fetchAttendance(studentId: studentId)
        }
        SDPickerView(viewModel: pickerViewModel).pickerStyle(.wheel)
    }

    private var topHeaderRightView: some View {
        HStack(spacing: Spacing.spacing2x) {
            SDImage(.local(resource: Icons.ic_share.value, iconSize: .medium))
                .pressEffect(onRelease: {
                    viewModel.attendaceSheetImage = monthSheetView.snapshot()
                    viewModel.isShareSheetPresented.toggle()
                })

            SDImage(.local(resource: Icons.ic_download.value, iconSize: .medium))
                .pressEffect(onRelease: {
                    
                })
        }
    }

    private var headerView: some View {
        let headerViewModel = AttendanceCalCardViewModel(
            header: AttendanceCalCardHeader(
                title1: "Day",
                title2: "Date",
                title3: "Status"
            )
        )

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

            SDText(
                title,
                style: .size90(
                    weight: .medium,
                    theme: .primary,
                    alignment: .center
                )
            )
        }
    }
}

private extension CornerRadius {
    static let headerCornerRadius: CGFloat = Sizing.sizing4x
}

#Preview {
    AttendanceCalanderView(studentId: 1)
        .padding()
}
