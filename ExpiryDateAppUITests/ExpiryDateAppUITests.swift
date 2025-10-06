import XCTest

final class ExpiryDateAppUITests: XCTestCase {
    override func setUp() {
        continueAfterFailure = false
    }

    func testAddButtonExists() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.buttons["addItemButton"].waitForExistence(timeout: 2))
    }
}
