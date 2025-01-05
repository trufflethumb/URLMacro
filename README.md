# URLMacro

A Swift macro that checks whether a URL is valid by using Foundation's URL.init(string:) and see if the result is `nil`. If it is non-nil, this macro also checks whether the URL has a scheme. This is because Foundation URLs with `invalid-url` as string argument is deemed by Foundation as a relative URL and is still considered valid.

## Usage
```swift
let url = #URL("https://example.com")

print(url.absoluteString) // prints https://example.com
```
