import SwiftUI

struct MomentRow: View {
    let event: CountdownEvent

    var body: some View {
        let progress = CountdownMath.progress(for: event)

        HStack(spacing: 14) {
            VStack(alignment: .leading, spacing: 4) {
                Text(event.name)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Theme.ink)
                    .lineLimit(1)

                Text(CountdownMath.remainingText(until: event.targetDate))
                    .font(.system(size: 12))
                    .foregroundStyle(Theme.muted)
            }

            Spacer()

            ProgressRing(progress: progress, lineWidth: 4) {
                Text(CountdownMath.percentText(progress))
                    .font(.system(size: 9, weight: .semibold))
                    .foregroundStyle(Theme.muted)
            }
            .frame(width: 42, height: 42)
        }
        .padding(.vertical, 14)
    }
}
