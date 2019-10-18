// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "CodableJSON",
    products: [
        .library(
            name: "CodableJSON",
            targets: ["CodableJSON"]),
    ],
    targets: [
        .target(
            name: "CodableJSON",
            path: "CodableJSON"),
        .testTarget(
            name: "CodableJSONTests",
            dependencies: ["CodableJSON"],
            path: "CodableJSONTests"),
    ]
)
