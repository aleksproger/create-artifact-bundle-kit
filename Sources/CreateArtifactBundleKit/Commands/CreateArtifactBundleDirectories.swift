import Foundation

struct CreateArtifactBundleDirectories: Command {
    private let configuration: FullFlowConfiguration

    init(_ configuration: FullFlowConfiguration) {
        self.configuration = configuration
    }

    func `do`() async -> Result<Void, Error>{
        do {
            try FileManager.default.createDirectory(atPath: configuration.variantBinaryDirectory, withIntermediateDirectories: true)
            return .success
        } catch {
            return .failure(error)
        }
    }

    func undo() async -> Result<Void, Error> {
        try? FileManager.default.removeItem(atPath: configuration.variantBinaryDirectory)
        return .success
    }
}