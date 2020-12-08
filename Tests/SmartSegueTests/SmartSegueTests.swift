import XCTest
@testable import SmartSegue

final class SmartSegueTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SmartSegue().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
