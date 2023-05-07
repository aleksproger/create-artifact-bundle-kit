import Foundation

public struct AsyncProcess {
    public init() {}  

    public static func run(_ url: URL, arguments: [String]) async throws {
        try await withCheckedThrowingContinuation { continuation in
            do {
                try Process.run(url, arguments: arguments, terminationHandler: { _ in continuation.resume() })
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }
}

public extension Sequence {
    func asyncForEach(
        _ operation: (Element) async throws -> Void
    ) async rethrows {
        for element in self {
            try await operation(element)
        }
    }
}