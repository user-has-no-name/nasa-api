// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Navigation",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Navigation",
            targets: ["Navigation"]
        ),
    ],
    targets: [
        .target(
            name: "Navigation"
        ),
        .testTarget(
            name: "NavigationTests",
            dependencies: ["Navigation"]
        ),
    ]
)
