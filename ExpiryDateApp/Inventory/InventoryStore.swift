import Foundation

final class InventoryStore: ObservableObject {
    @Published private(set) var items: [InventoryItem]

    private let calendar: Calendar

    init(calendar: Calendar = .current, items: [InventoryItem] = InventoryItem.sampleData) {
        self.calendar = calendar
        self.items = items.sorted(by: { $0.expirationDate < $1.expirationDate })
    }

    func add(_ item: InventoryItem) {
        items.append(item)
        items.sort(by: { $0.expirationDate < $1.expirationDate })
    }

    func removeItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }

    func expiringWithin(days: Int) -> [InventoryItem] {
        guard let cutoff = calendar.date(byAdding: .day, value: days, to: Date()) else {
            return []
        }
        return items.filter { $0.expirationDate <= cutoff }
    }
}
