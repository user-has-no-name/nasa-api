// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Animation",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Animation",
            targets: ["Animation"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/airbnb/lottie-spm.git",
            from: "4.3.3"
        )
    ],
    targets: [
        .target(
            name: "Animation",
            dependencies: [
                .product(name: "Lottie", package: "lottie-spm")
            ],
            resources: [
                .process("Resources")
            ]
        )
    ]
)
