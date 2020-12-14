import XCTest
import SwiftSyntax
@testable import SwiftAnnotation

final class SwiftAnnotationTests: XCTestCase {
    private let sourceSwiftAnnotationDir = "./Sources/SwiftAnnotation/"

    func testSwiftSyntax() {
        let outputPath = "./Sources/SwiftAnnotation/SwiftAnnotation_rewirter.swift"
        let outputURL = URL.init(fileURLWithPath: outputPath)
        let sourcePath = "./Sources/SwiftAnnotation/SwiftAnnotation.swift"
        let sourceURL = URL.init(fileURLWithPath: sourcePath)
        // 解析语法树
        let sourceFile = try! SyntaxParser.parse(sourceURL)
        let beforeStr = """
                        \n\tprint("before __format__")
                        """
        let afterStr = """
                        \n\tprint("after __format__")
                       """
        // 遍历语法树
        let content = FuncRewriterVisitor.init(formBeforeSource: beforeStr, formAfterSource: afterStr).visit(sourceFile)
        // 输出内容
        var fileContents: String = "";
        content.write(to: &fileContents)
        try? fileContents.write(to: outputURL, atomically: true, encoding: .utf8)
        print(fileContents)
    }

    static var allTests = [
        ("testSwiftSyntax", testSwiftSyntax),
    ]
}
