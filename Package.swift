// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AlpineUI",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "AlpineUI",
            targets: ["AlpineUI"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "AlpineUI",
            dependencies: [],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "AlpineUITests",
            dependencies: ["AlpineUI"]),
    ]
)
