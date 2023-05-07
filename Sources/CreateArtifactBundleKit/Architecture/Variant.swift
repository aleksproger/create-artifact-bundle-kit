import Foundation

public protocol Variant {
    var name: String { get }
    var triples: Set<String> { get }
    var binaries: [Binary] { get }
}

public struct Binary {
    public let triple: String
    public let path: String

    public init(triple: String, path: String) {
        self.triple = triple
        self.path = path
    }
}