import Foundation

struct CreateMetadataFile: Command {
    private let configuration: FullFlowConfiguration

    init(_ configuration: FullFlowConfiguration) {
        self.configuration = configuration
    }

    func `do`() async -> Result<Void, Error>{
        do {
            try configuration.artifactBundleMetadata.createJSON(at: configuration.metadataJSONFile)
            return .success
        } catch {
            return .failure(error)
        }
    }

    func undo() async -> Result<Void, Error> {
        try? FileManager.default.removeItem(atPath: configuration.metadataJSONFile)
        return .success
    }
}