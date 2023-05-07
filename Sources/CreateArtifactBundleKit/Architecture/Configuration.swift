import Foundation

public protocol Configuration {
    associatedtype V: Variant

    var target: String { get }
    var version: String { get }
    var outputDirectory: String { get }
    var variants: [V] { get }
}

extension Configuration {
    var artifactBundlePath: String {
        "\(outputDirectory)/\(target).artifactbundle"
    }

    func relativeVariantDirectory(for variant: String) -> String {
        "\(target)-\(version)-\(variant)/bin"
    }

    func relativeVariantBinaryPath(for variant: String) -> String {
        "\(relativeVariantDirectory(for: variant))/\(target)"
    }

    func variantBinaryPath(for variant: String) -> String {
        "\(artifactBundlePath)/\(relativeVariantBinaryPath(for: variant))"
    }

    func variantBinaryDirectory(for variant: String) ->  String {
        "\(artifactBundlePath)/\(relativeVariantDirectory(for: variant))"
    }

    var metadataJSONFile: String {
        "\(artifactBundlePath)/info.json"
    }
}

extension Configuration {
    var artifactBundleMetadata: ArtifactBundleMetadata {
        ArtifactBundleMetadata(
            schemaVersion: "1.0",
            artifacts: [
                target: ArtifactBundleMetadata.Artifact(
                    type: .executable,
                    version: version,
                    variants: variants.map { variant in
                        ArtifactBundleMetadata.Variant(
                            path: relativeVariantBinaryPath(for: variant.name),
                            supportedTriples: variant.triples
                        )
                    }
                )
            ]
        )
    }
}

struct ArtifactBundleMetadata: Encodable {
    struct Artifact: Encodable {
        enum `Type`: String, Encodable {
            case executable
        }
        let type: `Type`
        let version: String
        let variants: [Variant]
    }

    struct Variant: Encodable {
        let path: String
        let supportedTriples: Set<String>
    }

    let schemaVersion: String
    let artifacts: [String: Artifact]
}

extension ArtifactBundleMetadata {
    func createJSON(at path: String) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = JSONEncoder.OutputFormatting(arrayLiteral: [.prettyPrinted, .withoutEscapingSlashes])
        let metadataData = try encoder.encode(self)
        try metadataData.write(to: URL(fileURLWithPath: path))
    }
}
