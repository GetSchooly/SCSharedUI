import SwiftUI

/**
 
 *** Usage **
 
 Text("Loading...")
     .shimmer(if: isLoading)
 */

extension View {
    public func shimmer(isLoading: Bool) -> some View {
        Group {
            if isLoading {
                self
                    .redacted(reason: .placeholder)
                    .modifier(ShimmerViewModifier())
            } else {
                self
            }
        }
    }
}

struct ShimmerViewModifier: ViewModifier {
    @State private var phase: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .opacity(0.5)
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: [.gray.opacity(0.6), .gray.opacity(0.1), .gray.opacity(0.6)]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .rotationEffect(.degrees(0))
                .offset(x: phase)
                .blendMode(.overlay)
            )
            .onAppear {
                withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                    phase = 500
                }
            }
    }
}
