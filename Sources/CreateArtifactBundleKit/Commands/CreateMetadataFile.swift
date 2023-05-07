import Foundation

public struct CreateMetadataFile<C: Configuration>: Command {
    private let configuration: C

    public init(_ configuration: C) {
        self.configuration = configuration
    }

    public func `do`() async -> Result<Void, Error>{
        do {
            try configuration.artifactBundleMetadata.createJSON(at: configuration.metadataJSONFile)
            return .success
        } catch {
            return .failure(error)
        }
    }

    public func undo() async -> Result<Void, Error> {
        try? FileManager.default.removeItem(atPath: configuration.metadataJSONFile)
        return .success
    }
}