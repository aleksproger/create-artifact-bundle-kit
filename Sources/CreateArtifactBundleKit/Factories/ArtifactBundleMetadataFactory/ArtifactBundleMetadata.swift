import Foundation

public struct ArtifactBundleMetadata: Encodable {
    public struct Artifact: Encodable {
        public let type: ArtifactType
        public let version: String
        public let variants: [Variant]

        public init(
            type: ArtifactType,
            version: String,
            variants: [Variant]
        ) {
            self.type = type
            self.version = version
            self.variants = variants
        }
    }

    public enum ArtifactType: String, Encodable {
        case executable
    }

    public struct Variant: Encodable {
        public let path: String
        public let supportedTriples: Set<String>

        public init(
            path: String,
            supportedTriples: Set<String>
        ) {
            self.path = path
            self.supportedTriples = supportedTriples
        }
    }

    public let schemaVersion: String
    public let artifacts: [String: Artifact]

    public init(
        schemaVersion: String,
        artifacts: [String: Artifact]
    ) {
        self.schemaVersion = schemaVersion
        self.artifacts = artifacts
    }
}
