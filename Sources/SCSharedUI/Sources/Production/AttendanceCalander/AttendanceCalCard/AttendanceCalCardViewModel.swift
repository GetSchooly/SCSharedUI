import Foundation
import SCComponents
import SCTokens
import SwiftUI

enum AttendanceStatus: String, CaseIterable, Identifiable, Codable {
    var id: Self {
        return self
    }

    case present
    case absent
    case late
    case notMarked
    case holidays
    case none
    case upcoming
    case sunday

    var color: Color {
        switch self {
        case .present:
            return .green
        case .absent:
            return .error
        case .late:
            return .orange
        case .notMarked:
            return .darkGray
        case .holidays:
            return .blue
        case .upcoming:
            return .lightGray
        case .none:
            return .royalBlue10
        case .sunday:
            return .lightGray
        }
    }

    var icon: Icons {
        switch self {
        case .present:
            Icons.ic_present
        case .absent:
            Icons.ic_absent
        case .late:
            Icons.ic_late
        case .notMarked:
            Icons.ic_notMarked
        case .holidays:
            Icons.ic_festival
        case .none:
            Icons.ic_na
        case .upcoming:
            Icons.ic_empty
        case .sunday:
            Icons.ic_na
        }
    }

    var text: String {
        if self == .notMarked {
            return "Not Marked"
        }
        return self.rawValue.capitalized
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let raw = (try? container.decode(String.self)) ?? ""
        self = AttendanceStatus(rawValue: raw) ?? .none
    }
}

class AttendanceCalCardViewModel: ObservableObject {
    @Published private(set) var header: AttendanceCalCardHeader?
    @Published private(set) var item: AttendanceCalCardItem?

    // MARK:- Initialize
    init(header: AttendanceCalCardHeader? = nil, item: AttendanceCalCardItem? = nil) {
        self.header = header
        self.item = item
    }

    @ViewBuilder
    var itemView1: some View {
        if let header = header {
            SDText(header.title1, style: .size100(weight: .semiBold, theme: .standard, alignment: .center))
        } else if let item = item {
            SDText(item.title1, style: .size90(weight: .semiBold, theme: .primary, alignment: .center))
        }
        EmptyView()
    }

    @ViewBuilder
    var itemView2: some View {
        if let header = header {
            SDText(header.title2, style: .size100(weight: .semiBold, theme: .standard, alignment: .center))
        } else if let item = item {
            SDText(item.title2, style: .size90(weight: .semiBold, theme: .primary, alignment: .center))
        }
        EmptyView()
    }

    @ViewBuilder
    var itemView3: some View {
        if let header = header {
            SDText(header.title3, style: .size100(weight: .semiBold, theme: .standard, alignment: .center))
        } else if let item = item {
            SDImage(.local(resource: item.icon?.value ?? "", iconSize: .small, contentMode: .fit))
        }
        EmptyView()
    }
}
