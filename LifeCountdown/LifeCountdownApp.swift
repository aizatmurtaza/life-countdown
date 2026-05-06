import SwiftUI

@main
struct LifeCountdownApp: App {
    @StateObject private var eventStore = EventStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(eventStore)
        }
    }
}
