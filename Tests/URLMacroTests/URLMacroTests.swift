import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftDiagnostics
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(URLMacroMacros)
import URLMacroMacros

let testMacros: [String: Macro.Type] = [
    "URL": URLMacro.self,
]
#endif

final class URLMacroTests: XCTestCase {
    func testValidURL() {
        assertMacroExpansion(
            "#URL(\"https://example.com\")",
            expandedSource: "URL(string: \"https://example.com\")!",
            macros: testMacros
        )
    }

    func testInvalidURL() {
        assertMacroExpansion(
                """
                #URL("invalid-url")
                """,
                expandedSource:
                """
                #URL("invalid-url")
                """,
                diagnostics: [
                    DiagnosticSpec(message: "Invalid URL: invalid-url", line: 1, column: 1)
                ],
                macros: testMacros
        )
    }
}
