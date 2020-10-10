import XCTest
@testable import Sakura

final class SakuraTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SakuraModel().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
