import Foundation
import NetworkExtension
import Darwin

public struct AsyncProcess {
    public init() {} 

    public static func run(_ url: URL, arguments: [String]) async throws {
        try await withCheckedThrowingContinuation { continuation in
            do {
                try Process.run(url, arguments: arguments) { process in 
                    if process.terminationStatus == 0 { continuation.resume() } 
                    else { continuation.resume(throwing: AsyncProcessError.processFailed) }
                }
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }
}

private enum AsyncProcessError: Error {
    case processFailed
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