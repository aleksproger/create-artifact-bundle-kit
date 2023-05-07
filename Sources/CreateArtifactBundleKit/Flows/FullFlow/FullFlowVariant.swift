import Foundation

public struct FullFlowVariant: Variant {
    public let name: String
    public let triples: Set<String>
    public let binaries: [Binary]

    public init(
        name: String,
        triples: Set<String>,
        binaries: [Binary]
    ) {
        self.name = name
        self.triples = triples
        self.binaries = binaries
    }
}