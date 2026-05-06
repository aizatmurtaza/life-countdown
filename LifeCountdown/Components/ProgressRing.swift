import SwiftUI

struct ProgressRing<Content: View>: View {
    let progress: Double
    let lineWidth: CGFloat
    @ViewBuilder let content: Content

    init(progress: Double, lineWidth: CGFloat = 9, @ViewBuilder content: () -> Content) {
        self.progress = progress
        self.lineWidth = lineWidth
        self.content = content()
    }

    var body: some View {
        ZStack {
            Circle()
                .stroke(Theme.track, lineWidth: lineWidth)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(Theme.fill, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))

            content
        }
        .animation(.easeInOut(duration: 0.7), value: progress)
    }
}
