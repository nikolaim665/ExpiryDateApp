import XCTest
@testable import ExpiryDateApp

final class ExpiryDateAppTests: XCTestCase {
    func testExpiringWithinFiltersCorrectly() {
        let calendar = Calendar(identifier: .gregorian)
        let today = calendar.startOfDay(for: Date())
        let items = [
            InventoryItem(name: "Today", category: .produce, quantity: 1, expirationDate: today),
            InventoryItem(name: "Tomorrow", category: .produce, quantity: 1, expirationDate: calendar.date(byAdding: .day, value: 1, to: today)!),
            InventoryItem(name: "Next Week", category: .produce, quantity: 1, expirationDate: calendar.date(byAdding: .day, value: 7, to: today)!)
        ]
        let store = InventoryStore(calendar: calendar, items: items)

        let expiring = store.expiringWithin(days: 1)
        XCTAssertEqual(expiring.map { $0.name }, ["Today", "Tomorrow"])
    }
}
