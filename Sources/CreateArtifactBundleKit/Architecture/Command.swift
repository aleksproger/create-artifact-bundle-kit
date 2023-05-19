import Foundation

public protocol Command {
    func `do`() async -> Result<Void, Error>
    func undo() async -> Result<Void, Error>
}

extension Array where Element == Command {
    func execute() async throws {
        for i in 0..<count {
            do {
                try await self[i].do().get()
            } catch {
                await self[0..<i].asyncForEach { command in
                    await _ = command.undo()
                }
                throw error
            }
        }
    }
}

extension Result where Success == Void, Failure == Error {
    static var success: Self {
        .success(())
    }
}