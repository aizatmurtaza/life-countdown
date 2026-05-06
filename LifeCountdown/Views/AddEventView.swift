import SwiftUI

struct AddEventView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var eventStore: EventStore

    @State private var name = ""
    @State private var targetDate = Calendar.current.date(byAdding: .day, value: 30, to: Date()) ?? Date()

    private var remainingCharacters: Int {
        CountdownEvent.maxNameLength - name.count
    }

    private var canSave: Bool {
        !CountdownEvent.normalizedName(name).isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $name)
                        .textInputAutocapitalization(.words)
                        .onChange(of: name) { _, newValue in
                            if newValue.count > CountdownEvent.maxNameLength {
                                name = String(newValue.prefix(CountdownEvent.maxNameLength))
                            }
                        }

                    HStack {
                        Text("Characters")
                        Spacer()
                        Text("\(max(0, remainingCharacters))")
                            .foregroundStyle(Theme.muted)
                    }
                    .font(.footnote)
                }

                Section {
                    DatePicker("Date", selection: $targetDate, displayedComponents: .date)
                }
            }
            .navigationTitle("New Countdown")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        eventStore.add(name: name, targetDate: targetDate)
                        dismiss()
                    }
                    .disabled(!canSave)
                }
            }
        }
    }
}
