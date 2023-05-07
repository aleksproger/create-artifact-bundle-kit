import Foundation

public struct LipoBinaryFactory: UniversalBinaryFactory {
    public init() {}
    
    public func make(inputBinaries: [String],  outputBinary: String) async throws {
        try await AsyncProcess.run(
            URL(fileURLWithPath: "/usr/bin/lipo"),
            arguments: ["-create", "-output", outputBinary] + inputBinaries
        )
    }
}