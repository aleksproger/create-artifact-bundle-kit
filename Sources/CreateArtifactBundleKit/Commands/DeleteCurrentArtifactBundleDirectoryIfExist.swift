import Foundation

public struct DeleteCurrentArtifactBundleDirectoryIfExist<C: Configuration>: Command {
    private let configuration: C

    public init(_ configuration: C) {
        self.configuration = configuration
    }

    public func `do`() async -> Result<Void, Error> {
        try? FileManager.default.removeItem(atPath: configuration.artifactBundlePath)
        return .success
    }

    public func undo() async -> Result<Void, Error> {
        .success
    }
}