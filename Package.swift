// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JazzDataAccessInMemory",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "JazzDataAccessInMemory",
            targets: ["JazzDataAccessInMemory"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/JazzFramework/Jazz.git", from: "0.0.8")
    ],
    targets: [
        .target(
            name: "JazzDataAccessInMemory",
            dependencies: [
                .product(name: "JazzCodec", package: "Jazz"),
                .product(name: "JazzCore", package: "Jazz"),
                .product(name: "JazzDataAccess", package: "Jazz"),
            ]
        ),
        .testTarget(
            name: "JazzDataAccessInMemoryTests",
            dependencies: ["JazzDataAccessInMemory"]
        )
    ]
)
