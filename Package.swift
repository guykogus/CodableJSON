// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "CodableJSON",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_13),
        .tvOS(.v12),
        .visionOS(.v1),
        .watchOS(.v4),
    ],
    products: [
        .library(
            name: "CodableJSON",
            targets: ["CodableJSON"]
        ),
    ],
    targets: [
        .target(
            name: "CodableJSON"
        ),
        .testTarget(
            name: "CodableJSONTests",
            dependencies: ["CodableJSON"]
        ),
    ]
)
