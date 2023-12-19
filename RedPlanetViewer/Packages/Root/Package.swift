// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Root",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Root",
            targets: ["Root"]
        ),
    ],
    dependencies: [
        .package(path: "Navigation")
    ],
    targets: [
        .target(
            name: "Root",
            dependencies: [
                .byName(name: "Navigation")
            ]
        ),
        .testTarget(
            name: "RootTests",
            dependencies: ["Root"]
        ),
    ]
)
