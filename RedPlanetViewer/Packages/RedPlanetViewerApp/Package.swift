// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "RedPlanetViewerApp",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "RedPlanetViewerApp",
            targets: ["RedPlanetViewerApp"]
        ),
    ],
    dependencies: [
        .package(path: "Animation"),
        .package(path: "Commons"),
        .package(path: "Design"),
        .package(path: "Database"),
        .package(path: "DependencyInjection"),
        .package(path: "NasaAPIService"),
        .package(path: "Navigation"),
        .package(path: "SecretsManager"),
        .package(path: "UICommons"),
        .package(path: "UserDefaultsManager")
    ],
    targets: [
        .target(
            name: "RedPlanetViewerApp",
            dependencies: [
                .byName(name: "Animation"),
                .byName(name: "Commons"),
                .byName(name: "Design"),
                .byName(name: "Database"),
                .byName(name: "DependencyInjection"),
                .byName(name: "NasaAPIService"),
                .byName(name: "Navigation"),
                .byName(name: "SecretsManager"),
                .byName(name: "UICommons"),
                .byName(name: "UserDefaultsManager")
            ]
        ),
        .testTarget(
            name: "RedPlanetViewerAppTests",
            dependencies: [
                .byName(name: "RedPlanetViewerApp"),
            ]
        ),
    ]
)
