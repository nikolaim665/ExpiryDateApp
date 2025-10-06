import SwiftUI

struct InventoryListView: View {
    @EnvironmentObject private var inventoryStore: InventoryStore
    @State private var showingAddSheet = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(inventoryStore.items) { item in
                    InventoryRowView(item: item)
                }
                .onDelete(perform: inventoryStore.removeItems)
            }
            .navigationTitle("Expiring Soon")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddSheet = true
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                    .accessibilityIdentifier("addItemButton")
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                NavigationStack {
                    AddInventoryItemView()
                        .environmentObject(inventoryStore)
                }
            }
        }
    }
}

struct InventoryListView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryListView()
            .environmentObject(InventoryStore())
    }
}
