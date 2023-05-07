# CreateArtifactBundleKit

Package provides SDK for creating Artifact Bundles for Swift Package Manager.
Proposal regarding Artifact Bundles can be found [here](https://github.com/apple/swift-evolution/blob/main/proposals/0305-swiftpm-binary-target-improvements.md).

## Usage

Package provides `CreateArtifactBundleKit` library which can be used to create Artifact Bundles. It has two main options:

1. Build Artifact Bundle from an executable target in Swift Package.

```swift
    let configuration = FullFlowConfiguration(
        target: "TestExecutableTarget",
        version: "1.0.0",
        outputDirectory: "someAbsoluteDirectory",
        variants: [
            "macosx": ["arm64-apple-macosx", "x86_64-apple-macosx"],
        ],
        buildDirectory: "someAbsoluteDirectory",
        packageDirectory: "someAbsoluteDirectory"
    )

    let kit = Kits.fullFlow()
    try await kit.run(with: configuration)
```

Here the client defines the target, version, output directory, variants, build directory and package directory. The library will build the target for each triple and create an Artifact Bundle. The Artifact Bundle will be placed in the output directory. This option will invoke `swift build <target>` command in the package for each triple.

**Important: Now full flow option only works with macos triples, due to SPM limitations.**

2. Build Artifact Bundle from a set of prebuilt binaries.

```swift
        func run() async throws {
            let configuration = PrebuiltBinariesConfiguration(
                target: "TestExecutableTarget",
                version: "1.0.0",
                outputDirectory: "someAbsoluteDirectory",
                variants: [PrebuiltBinariesVariant(
                    name: "macosx",
                    binaries: [
                        PrebuiltBinary(
                            path: "someAbsoluteDirectory/TestExecutableTarget.xcframework",
                            supportedTriples: ["arm64-apple-macosx", "x86_64-apple-macosx"]
                        )
                    ],
                )]
            )

            let kit = Kits.prebuiltBinariesFlow()
            try await kit.run(with: configuration)
        }
```

Here the client defines the target, version, output directory, variants and prebuilt binaries. The library will create an Artifact Bundle from the prebuilt binaries. The Artifact Bundle will be placed in the output directory. This option is useful when the client has already built the binaries and wants to create an Artifact Bundle from them and also supports non-macos triples, so it's possible to creatr fully universal binary artifact compatible with SPM.

3. Build Artifact Bundle from XCFramework

Whereas 2nd option technically allows to build Artifact Bundle from XCFramework, efforts would be made to create a standalone option for this case.