import Foundation

struct InventoryItem: Identifiable, Equatable {
    let id: UUID
    var name: String
    var category: Category
    var quantity: Int
    var expirationDate: Date

    enum Category: String, CaseIterable, Codable, Identifiable {
        case produce
        case dairy
        case pantry
        case frozen
        case leftovers

        var id: String { rawValue }
        var label: String { rawValue.capitalized }
        var systemImageName: String {
            switch self {
            case .produce: return "leaf"
            case .dairy: return "carton.fill"
            case .pantry: return "shippingbox"
            case .frozen: return "snowflake"
            case .leftovers: return "takeoutbag.and.cup.and.straw.fill"
            }
        }
    }

    init(id: UUID = UUID(), name: String, category: Category, quantity: Int, expirationDate: Date) {
        self.id = id
        self.name = name
        self.category = category
        self.quantity = quantity
        self.expirationDate = expirationDate
    }
}

extension InventoryItem {
    var isExpired: Bool { expirationDate < Date() }

    static var sampleData: [InventoryItem] {
        let calendar = Calendar.current
        return [
            InventoryItem(name: "Milk", category: .dairy, quantity: 1, expirationDate: calendar.date(byAdding: .day, value: 2, to: Date()) ?? Date()),
            InventoryItem(name: "Spinach", category: .produce, quantity: 2, expirationDate: calendar.date(byAdding: .day, value: 1, to: Date()) ?? Date()),
            InventoryItem(name: "Chicken Soup", category: .pantry, quantity: 3, expirationDate: calendar.date(byAdding: .day, value: 30, to: Date()) ?? Date()),
            InventoryItem(name: "Frozen Berries", category: .frozen, quantity: 1, expirationDate: calendar.date(byAdding: .day, value: 90, to: Date()) ?? Date())
        ]
    }
}
