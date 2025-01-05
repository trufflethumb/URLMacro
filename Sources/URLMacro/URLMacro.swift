import Foundation

@freestanding(expression)
public macro URL(_ value: String) -> URL = #externalMacro(module: "URLMacroMacros", type: "URLMacro")
