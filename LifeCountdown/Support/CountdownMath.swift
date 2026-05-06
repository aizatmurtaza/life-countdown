import Foundation

enum CountdownMath {
    static func progress(for event: CountdownEvent, now: Date = Date(), calendar: Calendar = .current) -> Double {
        let start = calendar.startOfDay(for: event.createdAt)
        let end = calendar.startOfDay(for: event.targetDate)
        let current = calendar.startOfDay(for: now)
        guard end > start else { return current >= end ? 1 : 0 }
        return clamped(Double(current.timeIntervalSince(start)) / Double(end.timeIntervalSince(start)))
    }

    static func percentText(_ progress: Double) -> String {
        "\(Int((clamped(progress) * 100).rounded()))%"
    }

    static func remainingText(until targetDate: Date, now: Date = Date(), calendar: Calendar = .current) -> String {
        let today = calendar.startOfDay(for: now)
        let target = calendar.startOfDay(for: targetDate)
        let days = calendar.dateComponents([.day], from: today, to: target).day ?? 0

        if days < 0 { return "Passed" }
        if days == 0 { return "Today" }
        if days == 1 { return "1 day" }
        if days < 60 { return "\(days) days" }

        let months = max(1, Int((Double(days) / 30.44).rounded()))
        if months < 12 { return months == 1 ? "1 month" : "\(months) months" }

        let years = max(1, Int((Double(days) / 365.25).rounded()))
        return years == 1 ? "1 year" : "\(years) years"
    }

    static func dayProgress(now: Date = Date(), calendar: Calendar = .current) -> Double {
        let start = calendar.startOfDay(for: now)
        let end = calendar.date(byAdding: .day, value: 1, to: start) ?? now
        return progress(from: start, to: end, now: now)
    }

    static func weekProgress(now: Date = Date(), calendar: Calendar = .current) -> Double {
        let start = calendar.dateInterval(of: .weekOfYear, for: now)?.start ?? now
        let end = calendar.date(byAdding: .day, value: 7, to: start) ?? now
        return progress(from: start, to: end, now: now)
    }

    static func monthProgress(now: Date = Date(), calendar: Calendar = .current) -> Double {
        guard let interval = calendar.dateInterval(of: .month, for: now) else { return 0 }
        return progress(from: interval.start, to: interval.end, now: now)
    }

    static func yearProgress(now: Date = Date(), calendar: Calendar = .current) -> Double {
        guard let interval = calendar.dateInterval(of: .year, for: now) else { return 0 }
        return progress(from: interval.start, to: interval.end, now: now)
    }

    private static func progress(from start: Date, to end: Date, now: Date) -> Double {
        guard end > start else { return 0 }
        return clamped(Double(now.timeIntervalSince(start)) / Double(end.timeIntervalSince(start)))
    }

    private static func clamped(_ value: Double) -> Double {
        min(1, max(0, value))
    }
}
