import Foundation

struct DeleteCurrentArtifactBundleDirectoryIfExist: Command {
    private let configuration: FullFlowConfiguration

    init(_ configuration: FullFlowConfiguration) {
        self.configuration = configuration
    }

    func `do`() async -> Result<Void, Error> {
        try? FileManager.default.removeItem(atPath: configuration.artifactBundlePath)
        return .success
    }

    func undo() async -> Result<Void, Error> {
        .success
    }
}