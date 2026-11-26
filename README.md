# Swift Extensions

A collection of **useful Swift extensions** to speed up development and reduce boilerplate.

---

## Installation

### Swift Package Manager

In Xcode: **File → Add Package Dependencies…** and enter the repository URL, or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/bofiaza/swift-extensions.git", from: "1.0.0")
]
```

Then add the products you need to your target:

```swift
.target(
    name: "MyApp",
    dependencies: [
        .product(name: "SwiftExtensionsFoundation", package: "swift-extensions"),
        .product(name: "SwiftExtensionsSwiftUI", package: "swift-extensions")
    ]
)
```

| Product | Contents |
| --- | --- |
| `SwiftExtensionsFoundation` | Closure typealiases (`Action`, `Handler`, `Provider`, `Mapper`, `Condition`, …), `StubDefaults`, `Optional` and `URL` helpers |
| `SwiftExtensionsSwiftUI` | `applyIf`, `applyGlassEffect`, `applyAccessibilityInfo`, `StyledText` / `SimpleTextAttribute` |

Minimum platforms: iOS 15, macOS 12, tvOS 15, watchOS 8, visionOS 1. Requires Swift 6.0 (Xcode 16) or later.
On Linux only `SwiftExtensionsFoundation` is available.

See [CHANGELOG.md](CHANGELOG.md) for release notes.

### Manual

Copy the files you need into your project, or add the repository as a submodule:

```bash
git submodule add https://github.com/bofiaza/swift-extensions.git
```
