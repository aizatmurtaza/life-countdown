import SwiftUI

struct NowView: View {
    @EnvironmentObject private var eventStore: EventStore
    @Binding var showingAddEvent: Bool

    private let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    @State private var now = Date()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    yearProgress
                    timeRails
                    upcomingSection
                }
                .padding(24)
            }
            .background(Theme.paper.ignoresSafeArea())
            .navigationTitle("Now")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddEvent = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .onReceive(timer) { now = $0 }
        }
    }

    private var yearProgress: some View {
        let progress = CountdownMath.yearProgress(now: now)

        return ProgressRing(progress: progress) {
            VStack(spacing: 8) {
                Text(String(Calendar.current.component(.year, from: now)))
                    .font(.system(size: 46, weight: .regular, design: Theme.display))
                    .foregroundStyle(Theme.ink)
                Text("\(CountdownMath.percentText(progress)) elapsed")
                    .font(.system(size: 13))
                    .foregroundStyle(Theme.muted)
            }
        }
        .frame(maxWidth: 230)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
    }

    private var timeRails: some View {
        VStack(spacing: 16) {
            TimeRailRow(title: "Today", detail: dayCopy, progress: CountdownMath.dayProgress(now: now))
            TimeRailRow(title: "Week", detail: "\(CountdownMath.percentText(CountdownMath.weekProgress(now: now))) elapsed", progress: CountdownMath.weekProgress(now: now))
            TimeRailRow(title: "Month", detail: "\(CountdownMath.percentText(CountdownMath.monthProgress(now: now))) elapsed", progress: CountdownMath.monthProgress(now: now))
        }
    }

    private var upcomingSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Soon")
                .font(.system(size: 11, weight: .semibold))
                .textCase(.uppercase)
                .foregroundStyle(Theme.muted)

            if eventStore.upcomingEvents.isEmpty {
                Button {
                    showingAddEvent = true
                } label: {
                    Text("Add a countdown")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(Theme.ink)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 18)
                }
                .buttonStyle(.plain)
            } else {
                VStack(spacing: 0) {
                    ForEach(eventStore.upcomingEvents.prefix(2)) { event in
                        MomentRow(event: event)
                        Divider().overlay(Theme.line)
                    }
                }
            }
        }
    }

    private var dayCopy: String {
        let progress = CountdownMath.dayProgress(now: now)
        if progress < 0.45 { return "Still opening" }
        if progress < 0.65 { return "Halfway through" }
        return "Settling down"
    }
}

private struct TimeRailRow: View {
    let title: String
    let detail: String
    let progress: Double

    var body: some View {
        HStack(spacing: 14) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Theme.ink)
                Text(detail)
                    .font(.system(size: 12))
                    .foregroundStyle(Theme.muted)
            }
            .frame(width: 82, alignment: .leading)

            ProgressRail(progress: progress)
        }
    }
}
