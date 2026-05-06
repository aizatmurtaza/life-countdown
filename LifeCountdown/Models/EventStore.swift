import Foundation

@MainActor
final class EventStore: ObservableObject {
    @Published private(set) var events: [CountdownEvent] = [] {
        didSet { save() }
    }

    private let storageURL: URL

    init(storageURL: URL? = nil) {
        self.storageURL = storageURL ?? Self.defaultStorageURL
        events = Self.load(from: self.storageURL)
    }

    var upcomingEvents: [CountdownEvent] {
        let today = Calendar.current.startOfDay(for: Date())
        return events
            .filter { $0.targetDate >= today }
            .sorted { $0.targetDate < $1.targetDate }
    }

    func add(name: String, targetDate: Date) {
        let normalizedName = CountdownEvent.normalizedName(name)
        guard !normalizedName.isEmpty else { return }
        events.append(CountdownEvent(name: normalizedName, targetDate: targetDate))
    }

    func delete(_ event: CountdownEvent) {
        events.removeAll { $0.id == event.id }
    }

    private func save() {
        do {
            let folder = storageURL.deletingLastPathComponent()
            try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
            let data = try JSONEncoder().encode(events)
            try data.write(to: storageURL, options: [.atomic])
        } catch {
            assertionFailure("Unable to save events: \(error)")
        }
    }

    private static func load(from url: URL) -> [CountdownEvent] {
        guard let data = try? Data(contentsOf: url) else { return [] }
        return (try? JSONDecoder().decode([CountdownEvent].self, from: data)) ?? []
    }

    private static var defaultStorageURL: URL {
        FileManager.default
            .urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
            .appending(path: "LifeCountdown", directoryHint: .isDirectory)
            .appending(path: "events.json")
    }
}
