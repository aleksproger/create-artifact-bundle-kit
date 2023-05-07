import Foundation

public struct CreateUniversalBinary<C: Configuration>: Command {
    private let configuration: C
    private let universalBinaryFactory: UniversalBinaryFactory

    public init(
        _ configuration: C,
        _ universalBinaryFactory: UniversalBinaryFactory
    ) {
        self.configuration = configuration
        self.universalBinaryFactory = universalBinaryFactory
    }

    public func `do`() async -> Result<Void, Error>{
        do {
            try await configuration.variants.asyncForEach { variant in
                try await universalBinaryFactory.make(
                    inputBinaries: variant.binaries.map(\.path),
                    outputBinary: configuration.variantBinaryPath(for: variant.name)
                )
            }
            
            return .success
        } catch {
            return .failure(error)
        }
    }

    public func undo() async -> Result<Void, Error> {
        configuration.variants.forEach { variant in
            try? FileManager.default.removeItem(atPath: configuration.variantBinaryPath(for: variant.name))
        }
        return .success
    }
}