import Foundation
import SCComponents
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
        case .none:
            return .clear
        }
    }
    
    var text: String {
        if self == .notMarked {
            return "Not Marked"
        }
        return self.rawValue.capitalized
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
    
    // MARK: - Fetching functions
    func fetchData() {
        // Do something
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
