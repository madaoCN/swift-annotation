import XCTest
import SwiftSyntax

@testable import SwiftAnnotation

final class SwiftAnnotationTests: XCTestCase {
    private let sourceSwiftAnnotationDir = "./Sources/SwiftAnnotation/"

    func testSwiftSyntax() {
        
        // 遍历语法树
        let url = URL.init(fileURLWithPath: sourceSwiftAnnotationDir + "SwiftAnnotation.swift")
        let sourceFile = try? SyntaxTreeParser.parse(url)
        print(sourceFile)
    }

    static var allTests = [
        ("testSwiftSyntax", testSwiftSyntax),
    ]
}
