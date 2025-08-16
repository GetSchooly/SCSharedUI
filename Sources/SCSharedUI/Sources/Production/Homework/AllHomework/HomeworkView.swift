import SwiftUI
import SCComponents
import SCTokens

public struct HomeworkView: View {
    @StateObject var viewModel: HomeworkViewModel = .init()
    private let studentId: String
    private let selectedDate: String

    public init(studentId: String) {
        self.studentId = studentId
        self.selectedDate = "2025-05-31"
    }

    public var body: some View {
        Group {
            switch viewModel.loadingState.viewLoadingState {
            case .idle, .loading:
                mainContentView
                    .shimmer(isLoading: true)

            case .loaded:
                mainContentView

            case .failed(_):
                EmptyView()
            }
        }
        .task {
            viewModel.fetchStudentHomeworks(studentId: studentId, selectedDate: selectedDate)
        }
    }

    private var mainContentView: some View {
        VStack {
            weekCalendarView
            contentView
        }
    }

    private var contentView: some View {
        ZStack {
            content
        }
        .padding(.top, Spacing.spacing4x)
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
            .padding(.horizontal, Spacing.spacing4x)

            ScrollView(.vertical) {
                VStack(spacing: Spacing.spacing5x) {
                    taskListView(title: "Pending", tasks: viewModel.pendingHomeworks)

                    taskListView(title: "Completed", tasks: viewModel.completedHomeworks)
                }
                .padding(.top, Spacing.spacing2x)

                Spacer()
            }
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

    private func taskListView(title: String, tasks: [StudentTask]) -> some View {
        VStack(spacing: Spacing.spacing4x) {
            sectionTitleView("\(title)(\(tasks.count))")
                .padding(.horizontal, Spacing.spacing4x)

            ForEach(tasks) { item in
                HomeworkCard(studentTask: item)
                    .onTapGesture {
                        // TODO: - show homework detail
                    }
            }
            .padding(.horizontal, Spacing.spacing5x)
        }
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
    HomeworkView(studentId: "141")
}
