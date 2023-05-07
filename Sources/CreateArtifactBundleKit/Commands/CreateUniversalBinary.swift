import Foundation

struct CreateUniversalBinary: Command {
    private let configuration: FullFlowConfiguration
    private let universalBinaryFactory: UniversalBinaryFactory

    init(
        _ configuration: FullFlowConfiguration,
        _ universalBinaryFactory: UniversalBinaryFactory
    ) {
        self.configuration = configuration
        self.universalBinaryFactory = universalBinaryFactory
    }

    func `do`() async -> Result<Void, Error>{
        do {
            try await universalBinaryFactory.make(
                inputBinaries: configuration.executablePathes.map(\.path),
                outputBinary: configuration.variantBinary
            )
        
            return .success
        } catch {
            return .failure(error)
        }
    }

    func undo() async -> Result<Void, Error> {
        try? FileManager.default.removeItem(atPath: configuration.variantBinary)
        return .success
    }
}