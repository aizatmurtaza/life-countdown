import SwiftUI

struct ProgressRail: View {
    let progress: Double
    var height: CGFloat = 4

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Theme.track)
                Capsule()
                    .fill(Theme.fill)
                    .frame(width: proxy.size.width * progress)
            }
        }
        .frame(height: height)
        .animation(.easeInOut(duration: 0.7), value: progress)
    }
}
