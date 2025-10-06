import SwiftUI

struct AddInventoryItemView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var inventoryStore: InventoryStore

    @State private var name: String = ""
    @State private var category: InventoryItem.Category = .produce
    @State private var quantity: Int = 1
    @State private var expirationDate: Date = Calendar.current.date(byAdding: .day, value: 3, to: Date()) ?? Date()

    private var isSaveDisabled: Bool {
        name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || quantity < 1
    }

    var body: some View {
        Form {
            Section("Details") {
                TextField("Name", text: $name)
                Picker("Category", selection: $category) {
                    ForEach(InventoryItem.Category.allCases) { category in
                        Label(category.label, systemImage: category.systemImageName)
                            .tag(category)
                    }
                }
            }

            Section("Quantity & Expiration") {
                Stepper(value: $quantity, in: 1...99) {
                    Text("Quantity: \(quantity)")
                }
                DatePicker("Expires", selection: $expirationDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
            }
        }
        .navigationTitle("New Item")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel", role: .cancel) { dismiss() }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") { save() }
                    .disabled(isSaveDisabled)
            }
        }
    }

    private func save() {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return }

        let newItem = InventoryItem(
            name: trimmedName,
            category: category,
            quantity: quantity,
            expirationDate: expirationDate
        )
        inventoryStore.add(newItem)
        dismiss()
    }
}

struct AddInventoryItemView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddInventoryItemView()
                .environmentObject(InventoryStore())
        }
    }
}
