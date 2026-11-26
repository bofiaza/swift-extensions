// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "SwiftExtensions",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8),
        .visionOS(.v1)
    ],
    products: [
        .library(name: "SwiftExtensionsFoundation", targets: ["SwiftExtensionsFoundation"]),
        .library(name: "SwiftExtensionsSwiftUI", targets: ["SwiftExtensionsSwiftUI"])
    ],
    targets: [
        .target(
            name: "SwiftExtensionsFoundation",
            path: "Foundation"
        ),
        .target(
            name: "SwiftExtensionsSwiftUI",
            path: "SwiftUI"
        ),
        .testTarget(
            name: "SwiftExtensionsFoundationTests",
            dependencies: ["SwiftExtensionsFoundation"],
            path: "Tests/SwiftExtensionsFoundationTests"
        )
    ]
)
