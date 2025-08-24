import SwiftUI
import SCComponents
import SCTokens

struct AttendanceCalCardView: View {
    private let width: CGFloat?
    private let height: CGFloat?
    @ObservedObject private var viewModel: AttendanceCalCardViewModel

    init(
        viewModel: AttendanceCalCardViewModel,
        width: CGFloat = .infinity,
        height: CGFloat? = Sizing.sizing10x
    ) {
        self.viewModel = viewModel
        self.width = width
        self.height = height
    }

    var body: some View {
        singleDateView
    }

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    private var singleDateView: some View {
        LazyVGrid(columns: columns) {
            Group {
                dayView
                dateView
                statusView
            }
            .frame(width: width, height: height)
        }
        .border(viewModel.header != nil ? Color.royalBlue : Color.grayStroke, width: 0.5)
    }

    private var dayView: some View {
        HStack {
            Spacer()
            viewModel.itemView1
            Spacer()
            adDivider
        }
    }

    private var dateView: some View {
        HStack {
            Spacer()
            viewModel.itemView2
            Spacer()
        }
    }

    private var statusView: some View {
        HStack {
            adDivider
            Spacer()
            viewModel.itemView3
            Spacer()
        }
    }

    private var adDivider: some View {
        Rectangle()
            .fill(viewModel.header != nil ? Color.pantoneWhite : Color.grayStroke)
            .frame(width: 0.5)
    }
}

#Preview {
    let viewModel = AttendanceCalCardViewModel(item: AttendanceCalCardItem(title1: "Monday", title2: "02.09.2021", icon: .ic_info))
    AttendanceCalCardView(viewModel: viewModel, height: 40)
        .padding()
}
