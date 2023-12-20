// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Commons",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Commons",
            targets: ["Commons"]
        ),
    ],
    targets: [
        .target(
            name: "Commons"
        ),
        .testTarget(
            name: "CommonsTests",
            dependencies: ["Commons"]
        ),
    ]
)
