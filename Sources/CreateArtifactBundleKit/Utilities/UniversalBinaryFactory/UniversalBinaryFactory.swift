import Foundation

public protocol UniversalBinaryFactory {
    func make(inputBinaries: [String],  outputBinary: String) async throws
}