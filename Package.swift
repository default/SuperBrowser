// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SuperBrowser",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "SuperBrowser",
            targets: ["SuperBrowser"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/default/WindowInstanceManager",
            .upToNextMajor(from: "0.1.0")
        )
    ],
    targets: [
        .target(
            name: "SuperBrowser",
            dependencies: [
                .byName(name: "WindowInstanceManager")
            ],
            resources: [
                .process("Resources/Media.xcassets")
            ]
        )
    ]
)
