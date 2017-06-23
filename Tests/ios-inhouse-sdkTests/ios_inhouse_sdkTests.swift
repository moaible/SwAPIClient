import XCTest
@testable import ios_inhouse_sdk

class ios_inhouse_sdkTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(ios_inhouse_sdk().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
