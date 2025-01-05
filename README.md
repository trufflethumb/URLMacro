# URLMacro

A Swift macro that checks whether a URL is valid by using Foundation's `URL.init(string:)` and see if the result is `nil`. If it is non-nil, this macro also checks whether the URL has a scheme. This is because URLs without schemes (https, sftp) such as `invalid-url` is deemed by Foundation as a relative URL and is still considered valid.

## Usage
```swift
let url = #URL("https://example.com")
print(url.absoluteString) // prints https://example.com

let invalidURL = #URL("not a url") // compiler error: Invalid URL: not a url
let invalidURL2 = #URL("invalid-url") // compiler error: Invalid URL: invalid-url 
```
