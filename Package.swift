// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "create-artifact-bundle-kit",
    platforms: [.macOS(.v11)],
    products: [
        .library(name: "CreateArtifactBundleKit", targets: ["CreateArtifactBundleKit"]),
    ],
    targets: [
        .target(name: "CreateArtifactBundleKit"),
    ]
)
