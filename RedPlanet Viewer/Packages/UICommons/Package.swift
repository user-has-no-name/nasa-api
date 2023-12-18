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
        .package(path: "Design"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from: "7.0.0"))
    ],
    targets: [
        .target(
            name: "UICommons",
            dependencies: [
                .byName(name: "Design"),
                .byName(name: "Kingfisher")
            ]
        )
    ]
)
