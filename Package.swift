// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Pinnable",
    platforms: [
        .iOS(.v12),
    ],
    products: [
        .library(name: "Pinnable", targets: ["Pinnable"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
    ],
    targets: [
        .target(name: "Pinnable"),
    ]
)
