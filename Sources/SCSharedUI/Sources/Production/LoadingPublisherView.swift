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
    
    public var viewLoadingState: ViewLoadingState {
        switch self {
        case .idle: return .idle
        case .loading: return .loading
        case .loaded: return .loaded
        case .failed(let error): return .failed(error)
        }
    }
}

public extension LoadingState where T == Void {
    static var loaded: LoadingState<Void> {
        return .loaded(())
    }
}

public typealias ViewLoadingState = LoadingState<Void>

public struct LoadableView<T: Codable, Content: View>: View {
    public let refreshTrigger: UUID
    @ObservedObject public var viewModel: LoadableViewModel<T>
    public let publisher: () -> AnyPublisher<ResponseModel<T>, Error>
    @ViewBuilder public let content: () -> Content

    @State private var didLoad = false

    public var body: some View {
        content()
        .onAppear {
            if !didLoad {
                didLoad = true
                if case .idle = viewModel.loadingState {
                    viewModel.load(publisher: publisher())
                }
            }
        }
        .onChange(of: refreshTrigger) { _ in
            viewModel.load(publisher: publisher())
        }
    }
}

public struct LoadingViewHelper {
    public static var defaultLoadingView: some View {
        ZStack {
            Color.lightGray.opacity(0.6)
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
    
    public static func errorView(errorMessage: String, buttonText: String = "Retry", onRetry: @escaping () -> Void) -> some View {
        ZStack {
            Color.appwhite
            VStack {
                SDText(errorMessage,
                       style: .size200(weight: .regular, theme: .primary, alignment: .center))
                //Text("Failed: \(error.localizedDescription)")
                .multilineTextAlignment(.center)
                .padding()
                
                SDButton(buttonText,
                         buttonType: .primaryButton(.size200(weight: .bold, theme: .standard, alignment: .center)),
                         maxSize: true) {
                    onRetry()
                }
                         .frame(width: 240, height: Sizing.sizing12x)
            }
        }
        .ignoresSafeArea()
    }
}

open class LoadableViewModel<T: Codable>: ObservableObject {
    @Published public var loadingState: LoadingState<T> = .idle
    private var cancellable: AnyCancellable?
    private var lastPublisher: AnyPublisher<ResponseModel<T>, Error>?

    public init() {}

    open func load(publisher: AnyPublisher<ResponseModel<T>, Error>) {
        cancellable?.cancel() // cancel all previous call
        loadingState = .loading
        lastPublisher = publisher

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
                    self?.loadingState = .failed(APIError.serverError(reason: value.meta.successMessage ?? "Something went wrong!!"))
                }
            })
    }

    open func reset() {
        loadingState = .idle
        cancellable?.cancel()
        cancellable = nil
    }
    
    open func retry() {
        guard let publisher = lastPublisher else { return }
        load(publisher: publisher)
    }
}
