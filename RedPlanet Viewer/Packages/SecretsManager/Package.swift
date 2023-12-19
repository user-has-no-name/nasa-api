// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SecretsManager",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "SecretsManager",
            targets: ["SecretsManager"]
        ),
    ],
    targets: [
        .target(
            name: "SecretsManager",
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "SecretsManagerTests",
            dependencies: ["SecretsManager"]
        )
    ]
)
