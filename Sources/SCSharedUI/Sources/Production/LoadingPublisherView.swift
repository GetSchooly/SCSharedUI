import Foundation
import Combine
import SwiftUI
import SCComponents
import SCTokens
import LoaderUI

public enum LoadingState<T> {
    case idle
    case loading
    case loaded(T)
    case failed(Error)
}

public struct LoadableView<T: Codable, Content: View>: View {
    @StateObject private var viewModel = LoadableViewModel<T>()
    
    private let publisher: () -> AnyPublisher<ResponseModel<T>, Error>
    private let content: (T) -> Content

    public init(publisher: @escaping () -> AnyPublisher<ResponseModel<T>, Error>, content: @escaping (T) -> Content) {
        self.publisher = publisher
        self.content = content
    }
    
    public var body: some View {
        VStack {
            switch viewModel.loadingState {
            case .idle, .loading:
                LoadingViewHelper.defaultLoadingView
                
            case .loaded(let data):
                content(data)
                
            case .failed(let error):
                LoadingViewHelper.errorView(error: error) {
                    viewModel.load(publisher: publisher())
                }
            }
        }
        .onAppear {
            if case .idle = viewModel.loadingState {
                viewModel.load(publisher: publisher())
            }
        }
    }
}

public struct LoadingViewHelper {
    public static var defaultLoadingView: some View {
        ZStack {
            Color.royalBlue.opacity(0.1)
            BallClipRotateMultiple()
                .foregroundStyle(Color.royalBlue)
                .frame(width: Sizing.sizing14x, height: Sizing.sizing14x)
            //            BallClipRotateMultiple()
            SDImage(.local(resource: Icons.ic_myschool_logo.value, iconSize: .custom(width: Sizing.sizing9x, height: Sizing.sizing9x)))
                .background(Color.appwhite)
                .clipShape(.circle)
        }
        .ignoresSafeArea()
    }
    
    public static func errorView(error: Error, onRetry: @escaping () -> Void) -> some View {
        VStack {
            SDText(error.localizedDescription,
                   style: .size200(weight: .regular, theme: .royalBlue, alignment: .center))
            //Text("Failed: \(error.localizedDescription)")
                .multilineTextAlignment(.center)
                .padding()
            
            SDButton("Retry",
                     buttonType: .royalBlueBordered(.size200(weight: .regular, theme: .standard, alignment: .center)),
                     maxSize: true) {
                onRetry()
            }
        }
        .ignoresSafeArea()
    }
}

open class LoadableViewModel<T: Codable>: ObservableObject {
    @Published private(set) public var loadingState: LoadingState<T> = .idle
    private var cancellable: AnyCancellable?

    public init() {}
    
    open func load(publisher: AnyPublisher<ResponseModel<T>, Error>) {
        loadingState = .loading
        cancellable = publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.loadingState = .failed(error)
                }
            }, receiveValue: { [weak self] value in
                if let response = value.response {
                    self?.loadingState = .loaded(response)
                } else {
                    self?.loadingState = .failed(APIError.serverError(reason: value.meta.successMessage))
                }
            })
    }

    open func reset() {
        loadingState = .idle
        cancellable?.cancel()
        cancellable = nil
    }
}
