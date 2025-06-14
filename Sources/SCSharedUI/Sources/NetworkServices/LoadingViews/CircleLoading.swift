import SwiftUI

public struct CircleZoomLoading<Content>: View where Content: View {
    
    let content: Content
    
    @State private var animate = false
    @State private var showHome: Bool = false
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        ZStack {
            if showHome {
                content.transition(.opacity)
            } else {
                Circle()
                    .fill(Color.royalBlue)
                    .frame(width: 1, height: 1)
                    .scaleEffect(animate ? 50 : 1)
                    .opacity(animate ? 0 : 1)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            animate = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            withAnimation {
                                showHome = true
                            }
                        }
                    }
            }
        }
        .ignoresSafeArea()
    }
    
}
