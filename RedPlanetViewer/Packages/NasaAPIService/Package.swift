// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "NasaAPIService",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "NasaAPIService",
            targets: ["NasaAPIService"]
        ),
    ],
    dependencies: [
        .package(path: "Commons"),
        .package(path: "Networking")
    ],
    targets: [
        .target(
            name: "NasaAPIService",
            dependencies: [
                .byName(name: "Commons"),
                .byName(name: "Networking")
            ]
        ),
        .testTarget(
            name: "NasaAPIServiceTests",
            dependencies: ["NasaAPIService"]
        ),
    ]
)
