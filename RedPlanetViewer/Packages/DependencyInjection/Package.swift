// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DependencyInjection",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "DependencyInjection",
            targets: ["DependencyInjection"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick", exact: Version(7,3,0)),
        .package(url: "https://github.com/Quick/Nimble", exact: Version(12,3,0))
    ],
    targets: [
        .target(
            name: "DependencyInjection"
        ),
        .testTarget(
            name: "DependencyInjectionTests",
            dependencies: ["DependencyInjection",
                           "Quick",
                           "Nimble"]
        ),
    ]
)
