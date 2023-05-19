import Foundation

public protocol Variant {
    var name: String { get }
    var triples: Set<String> { get }
    var binaries: [Binary] { get }
}

public struct Binary {
    public let triples: [String]
    public let path: String

    public init(triple: String, path: String) {
        self.triples = [triple]
        self.path = path
    }

    public init(triples: [String], path: String) {
        self.triples = triples
        self.path = path
    }
}