import XCTest
@testable import SwiftAnnotation

final class SwiftAnnotationTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftAnnotation().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
