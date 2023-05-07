public struct FullFlowConfiguration {
    public let target: String
    public let version: String
    public let triples: Set<String>
    public let rootDirectory: String
    public let buildDirectory: String
}

public struct ExecutablePath {
    let triple: String
    let path: String
}

extension FullFlowConfiguration {
    var artifactBundlePath: String {
        "\(rootDirectory)/\(target).artifactbundle"
    }

    var metadataJSONFile: String {
        "\(artifactBundlePath)/info.json"
    }

    var relativeVariantDirectory: String {
        "\(target)-\(version)-macosx/bin"
    }

    var relativeVariantBinary: String {
        "\(relativeVariantDirectory)/\(target)"
    }

    var variantBinary: String {
        "\(artifactBundlePath)/\(relativeVariantBinary)"
    }

    var variantBinaryDirectory: String {
        "\(artifactBundlePath)/\(relativeVariantDirectory)"
    }

    var executablePathes: [ExecutablePath] {
        triples.map { triple in
            ExecutablePath(
                triple: triple,
                path: "\(buildDirectory)/\(triple)/release/\(target)"
            )
        }
    }
}

extension FullFlowConfiguration {
    var artifactBundleMetadata: ArtifactBundleMetadata {
        ArtifactBundleMetadata(
            schemaVersion: "1.0",
            artifacts: [
                target: ArtifactBundleMetadata.Artifact(
                    type: .executable,
                    version: version,
                    variants: [ArtifactBundleMetadata.Variant(
                        path: relativeVariantBinary,
                        supportedTriples: triples
                    )]
                )
            ]
        )
    }
}