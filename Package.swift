// swift-tools-version:5.8

import PackageDescription

let package = Package(
    name: "CodableJSON",
    products: [
        .library(
            name: "CodableJSON",
            targets: ["CodableJSON"]
        ),
    ],
    targets: [
        .target(
            name: "CodableJSON",
            path: "CodableJSON",
            swiftSettings: [
                .enableUpcomingFeature("ConciseMagicFile"),
                .enableUpcomingFeature("ExistentialAny"),
                .enableUpcomingFeature("ForwardTrailingClosures"),
            ]
        ),
        .testTarget(
            name: "CodableJSONTests",
            dependencies: ["CodableJSON"],
            path: "CodableJSONTests",
            swiftSettings: [
                .enableUpcomingFeature("ConciseMagicFile"),
                .enableUpcomingFeature("ExistentialAny"),
                .enableUpcomingFeature("ForwardTrailingClosures"),
            ]
        ),
    ]
)
