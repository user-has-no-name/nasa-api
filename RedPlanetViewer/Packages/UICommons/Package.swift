// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "UICommons",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "UICommons",
            targets: ["UICommons"]
        ),
    ],
    dependencies: [
        .package(path: "Animation"),
        .package(path: "Commons"),
        .package(path: "Design")
    ],
    targets: [
        .target(
            name: "UICommons",
            dependencies: [
                .byName(name: "Animation"),
                .byName(name: "Commons"),
                .byName(name: "Design")
            ]
        )
    ]
)
