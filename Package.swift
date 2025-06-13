// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SCSharedUI",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SCSharedUI",
            targets: ["SCSharedUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/GetSchooly/SCTokens", .upToNextMajor(from: Version("1.0.9"))),
        .package(url: "https://github.com/GetSchooly/SCComponents", .upToNextMajor(from: Version("1.0.8"))),
        .package(url: "https://github.com/ninjaprox/LoaderUI", from: "0.2.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SCSharedUI",
            dependencies: ["SCComponents",
                           "SCTokens",
                           "LoaderUI"
                          ],
            path: "Sources",
            resources: [
                
            ]),
        .testTarget(
            name: "SCSharedUITests",
            dependencies: ["SCSharedUI"]),
    ]
)
