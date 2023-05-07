public protocol ArgumentsBasedKit {
    func run(with description: Arguments) async throws
}

public struct Arguments {
    let value: [String]

    public init(_ value: [String]) {
        self.value = value
    }
}

extension CreateArtifactBundleKit: ArgumentsBasedKit where Description == Arguments {}
