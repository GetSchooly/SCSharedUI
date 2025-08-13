import SwiftUI
import SCComponents

struct QuizChapterListView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: QuizChapterListViewModel = .init()
    private let uniqueID: String
    private let subjectName: String
    private let onSelect: (Int) -> Void

    init(
        uniqueID: String,
        subjectName: String,
        onSelect: @escaping (Int) -> Void
    ) {
        self.uniqueID = uniqueID
        self.subjectName = subjectName
        self.onSelect = onSelect
    }

    var body: some View {
        Group {
            switch viewModel.loadingState.viewLoadingState {
            case .idle, .loading:
                chaptersBottomSheet
                    .shimmer(isLoading: true)

            case .loaded:
                chaptersBottomSheet

            case .failed(_):
                EmptyView()
            }
        }
        .task {
            viewModel.fetchQuizChapterList(subjectID: uniqueID)
        }
    }

    private var chaptersBottomSheet: some View {
        SDBottomList(
            title: subjectName,
            items: viewModel.chaptersTitle) { index, _ in
                onSelect(index)
            } onClose: {
                dismiss()
            }
    }
}
