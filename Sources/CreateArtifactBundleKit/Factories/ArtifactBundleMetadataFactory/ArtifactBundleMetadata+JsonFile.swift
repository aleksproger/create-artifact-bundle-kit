import Foundation

extension ArtifactBundleMetadata {
    func createJSON(at path: String) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = JSONEncoder.OutputFormatting(arrayLiteral: [.prettyPrinted, .withoutEscapingSlashes])
        let metadataData = try encoder.encode(self)
        try metadataData.write(to: URL(fileURLWithPath: path))
    }
}