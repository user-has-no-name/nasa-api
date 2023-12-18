// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Design",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "Design",
            targets: ["Design"]
        ),
    ],
    targets: [
        .target(
            name: "Design",
            resources: [
                .process("Resources/")
            ]
        ),
    ]
)
