import SwiftUI

struct RootView: View {
    @EnvironmentObject private var eventStore: EventStore
    @State private var showingAddEvent = false
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            NowView(showingAddEvent: $showingAddEvent)
                .tabItem { Label("Now", systemImage: "circle") }
                .tag(0)

            MomentsView(showingAddEvent: $showingAddEvent)
                .tabItem { Label("Moments", systemImage: "line.3.horizontal") }
                .tag(1)
        }
        .tint(Theme.ink)
        .sheet(isPresented: $showingAddEvent) {
            AddEventView()
                .environmentObject(eventStore)
                .presentationDetents([.medium])
        }
    }
}
