import Foundation

public struct CleanBuildAllTriples: Command {
    private let configuration: FullFlowConfiguration

    public init(_ configuration: FullFlowConfiguration) {
        self.configuration = configuration
    }

    public func `do`() async -> Result<Void, Error> {
        do {
            try? FileManager.default.removeItem(atPath: configuration.buildDirectory)

            try await configuration.variants.asyncForEach { variant in
                try await variant.triples.asyncForEach { triple in
                    try await AsyncProcess.run(
                        URL(fileURLWithPath: "/usr/bin/swift"),
                        arguments: ["build", "-c", "release", "--triple", triple]
                    )
                }
            }

            return .success
        } catch {
            return .failure(error)
        }
    }

    public func undo() async -> Result<Void, Error> {
        try? FileManager.default.removeItem(atPath: configuration.buildDirectory)
        return .success
    }
}