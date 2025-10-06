import SwiftUI

@main
struct ExpiryDateAppApp: App {
    @StateObject private var inventoryStore = InventoryStore()

    var body: some Scene {
        WindowGroup {
            InventoryListView()
                .environmentObject(inventoryStore)
        }
    }
}
