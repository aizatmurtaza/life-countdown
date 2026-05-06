import SwiftUI

struct MomentsView: View {
    @EnvironmentObject private var eventStore: EventStore
    @Binding var showingAddEvent: Bool

    var body: some View {
        NavigationStack {
            List {
                if eventStore.upcomingEvents.isEmpty {
                    emptyState
                        .listRowBackground(Color.clear)
                } else {
                    Section("Upcoming") {
                        ForEach(eventStore.upcomingEvents) { event in
                            MomentRow(event: event)
                                .swipeActions {
                                    Button(role: .destructive) {
                                        eventStore.delete(event)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(Theme.paper.ignoresSafeArea())
            .navigationTitle("Moments")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddEvent = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }

    private var emptyState: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("No countdowns yet")
                .font(.system(size: 22, weight: .regular, design: Theme.display))
                .foregroundStyle(Theme.ink)
            Text("Add a name and date to begin.")
                .font(.system(size: 14))
                .foregroundStyle(Theme.muted)
        }
        .padding(.vertical, 24)
    }
}
