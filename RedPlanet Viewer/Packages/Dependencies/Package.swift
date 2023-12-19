// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Dependencies",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Dependencies",
            targets: ["Dependencies"]
        ),
    ],
    dependencies: [
        .package(path: "DependencyInjection"),
        .package(path: "NasaAPIService"),
        .package(path: "SecretsManager"),
    ],
    targets: [
        .target(
            name: "Dependencies",
            dependencies: [
                .byName(name: "DependencyInjection"),
                .byName(name: "NasaAPIService"),
                .byName(name: "SecretsManager")
            ]
        ),
    ]
)
