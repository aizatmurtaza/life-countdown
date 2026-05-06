import Foundation

struct CountdownEvent: Identifiable, Codable, Equatable {
    static let maxNameLength = 32

    let id: UUID
    var name: String
    var targetDate: Date
    let createdAt: Date

    init(id: UUID = UUID(), name: String, targetDate: Date, createdAt: Date = Date()) {
        self.id = id
        self.name = Self.normalizedName(name)
        self.targetDate = Calendar.current.startOfDay(for: targetDate)
        self.createdAt = Calendar.current.startOfDay(for: createdAt)
    }

    static func normalizedName(_ rawValue: String) -> String {
        let trimmed = rawValue.trimmingCharacters(in: .whitespacesAndNewlines)
        return String(trimmed.prefix(maxNameLength))
    }
}
