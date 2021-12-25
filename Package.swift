// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Pinnable",
    platforms: [
        .iOS(.v9),
    ],
    products: [
        .library(name: "Pinnable", targets: ["Pinnable"]),
    ],
    targets: [
        .target(name: "Pinnable"),
    ]
)
