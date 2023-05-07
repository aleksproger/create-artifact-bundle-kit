import Foundation

public struct CreateArtifactBundleDirectories<C: Configuration>: Command {
    private let configuration: C

    public init(_ configuration: C) {
        self.configuration = configuration
    }

    public func `do`() async -> Result<Void, Error>{
        do {
            try configuration.variants.forEach { variant in
                try FileManager.default.createDirectory(atPath: configuration.variantBinaryDirectory(for: variant.name), withIntermediateDirectories: true)
            }
            return .success
        } catch {
            return .failure(error)
        }
    }

    public func undo() async -> Result<Void, Error> {
        try? configuration.variants.forEach { variant in
            try FileManager.default.removeItem(atPath: configuration.variantBinaryDirectory(for: variant.name))
        }

        return .success
    }
}
