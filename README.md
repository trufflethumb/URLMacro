# URLMacro

A Swift macro that expands to a URL initializer (`URL(string: "<any valid URL>")!`) after making sure the URL is valid.

The validation is done by using Foundation's `URL.init(string:)` and throws a diagnostic error if the result is `nil`. If the result is non-nil, this macro continues to checks whether the URL has a scheme. This is because URLs without schemes (https, sftp) such as `invalid-url` is deemed by Foundation as a relative URL and is still considered valid.

## Usage
```swift
let url = #URL("https://example.com")
print(url.absoluteString) // prints https://example.com

let invalidURL = #URL("not a url") // compiler error: Invalid URL: not a url
let invalidURL2 = #URL("invalid-url") // compiler error: Invalid URL: invalid-url 
```
