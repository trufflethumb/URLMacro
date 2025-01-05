import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftDiagnostics
import Foundation

public struct URLMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        guard let argument = node.arguments.first?.expression.as(StringLiteralExprSyntax.self),
              let urlString = argument.segments.first?.description.trimmingCharacters(in: .quotes)
        else {
            throw makeError(node._syntaxNode, "The `#URL` macro requires a single string literal as input.")
        }

        guard let url = URL(string: urlString), url.scheme != nil else {
            throw makeError(node._syntaxNode, "Invalid URL: \(urlString)")
        }

        return "\(raw: "URL(string: \"\(urlString)\")!")"
    }

    private static func makeError(_ syntax: Syntax, _ message: String) -> DiagnosticsError {
        DiagnosticsError(
            diagnostics: [Diagnostic(
                node: syntax,
                message: message as DiagnosticMessage
            )]
        )
    }
}

extension String: @retroactive DiagnosticMessage {
    public var message: String {
        self
    }
    
    public var diagnosticID: SwiftDiagnostics.MessageID {
        .init(domain: "domain", id: self)
    }
    
    public var severity: SwiftDiagnostics.DiagnosticSeverity {
        .error
    }
}

@main
struct URLMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        URLMacro.self,
    ]
}

private extension CharacterSet {
    static let quotes = CharacterSet(charactersIn: "\"")
}
