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
    targets: [
        .target(name: "Pinnable"),
    ]
)
