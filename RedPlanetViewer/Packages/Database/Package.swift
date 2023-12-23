// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Database",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Database",
            targets: ["Database"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/realm/realm-swift.git", .upToNextMajor(from: "10.45.0"))
    ],
    targets: [
        .target(
            name: "Database",
            dependencies: [
                .product(name: "RealmSwift", package: "realm-swift")
            ]
        ),
        .testTarget(
            name: "DatabaseTests",
            dependencies: ["Database"]
        ),
    ]
)
