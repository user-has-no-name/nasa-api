// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "UserDefaultsManager",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "UserDefaultsManager",
            targets: ["UserDefaultsManager"]
        ),
    ],
    targets: [
        .target(
            name: "UserDefaultsManager"
        ),
        .testTarget(
            name: "UserDefaultsManagerTests",
            dependencies: ["UserDefaultsManager"]
        ),
    ]
)
