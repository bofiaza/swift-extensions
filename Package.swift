// swift-tools-version: 6.0
import PackageDescription

var products: [Product] = [
    .library(name: "SwiftExtensionsFoundation", targets: ["SwiftExtensionsFoundation"])
]

var targets: [Target] = [
    .target(
        name: "SwiftExtensionsFoundation",
        path: "Foundation"
    ),
    .testTarget(
        name: "SwiftExtensionsFoundationTests",
        dependencies: ["SwiftExtensionsFoundation"],
        path: "Tests/SwiftExtensionsFoundationTests"
    )
]

// SwiftUI only exists on Apple platforms; leaving the target out elsewhere
// lets the Foundation target build and test on Linux.
#if canImport(Darwin)
products.append(
    .library(name: "SwiftExtensionsSwiftUI", targets: ["SwiftExtensionsSwiftUI"])
)
targets.append(
    .target(
        name: "SwiftExtensionsSwiftUI",
        path: "SwiftUI"
    )
)
#endif

let package = Package(
    name: "SwiftExtensions",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8),
        .visionOS(.v1)
    ],
    products: products,
    targets: targets
)
