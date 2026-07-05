import SwiftUI

struct GlassCard<Content: View>: View {

    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {

        content
            .padding(.vertical, 18)
            .padding(.horizontal, 20)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 26, style: .continuous)
                    .stroke(.white.opacity(0.08), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.25), radius: 18, x: 0, y: 10)
    }
}
