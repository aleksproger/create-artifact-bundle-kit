import Foundation

struct CleanBuildAllTriples: Command {
    private let configuration: FullFlowConfiguration

    init(_ configuration: FullFlowConfiguration) {
        self.configuration = configuration
    }

    func `do`() async -> Result<Void, Error> {
        do {
            try? FileManager.default.removeItem(atPath: configuration.buildDirectory)

            try await configuration.executablePathes.asyncForEach { path in
                try await AsyncProcess.run(
                    URL(fileURLWithPath: "/usr/bin/swift"),
                    arguments: ["build", "-c", "release", "--triple", path.triple]
                )
            }

            return .success
        } catch {
            return .failure(error)
        }
    }

    func undo() async -> Result<Void, Error> {
        try? FileManager.default.removeItem(atPath: configuration.buildDirectory)
        return .success
    }
}