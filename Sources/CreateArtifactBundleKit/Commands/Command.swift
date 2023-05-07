import Foundation

public protocol Command {
    func `do`() async -> Result<Void, Error>
    func undo() async -> Result<Void, Error>
}

extension Array where Element == Command {
    func execute() async throws {
         try await self.asyncForEach { command in
            do {
                try await command.do().get()
            } catch {
                await _ = command.undo()
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