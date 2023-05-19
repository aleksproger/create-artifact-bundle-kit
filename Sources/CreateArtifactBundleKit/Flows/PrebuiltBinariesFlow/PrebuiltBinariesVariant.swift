import Foundation

public struct PrebuiltBinariesVariant: Variant {
    public let name: String
    public let binaries: [Binary]
    public let triples: Set<String>

    public init(name: String, binaries: [Binary]) {
        self.name = name
        self.binaries = binaries
        self.triples = Set(binaries.flatMap(\.triples))
    }
}