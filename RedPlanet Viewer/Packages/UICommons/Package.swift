// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "UICommons",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "UICommons",
            targets: ["UICommons"]
        ),
    ],
    targets: [
        .target(
            name: "UICommons"
        )
    ]
)
