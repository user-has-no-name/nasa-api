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
        .package(path: "Navigation"),
        .package(path: "RedPlanetViewerApp")
    ],
    targets: [
        .target(
            name: "Root",
            dependencies: [
                .byName(name: "Navigation"),
                .byName(name: "RedPlanetViewerApp")
            ]
        ),
        .testTarget(
            name: "RootTests",
            dependencies: ["Root"]
        ),
    ]
)
