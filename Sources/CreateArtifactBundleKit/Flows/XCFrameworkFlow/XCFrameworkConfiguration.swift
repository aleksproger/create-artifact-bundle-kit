import Foundation

public struct XCFrameworkConfiguration: Configuration {
    public typealias V = PrebuiltBinariesVariant

    public let target: String
    public let xcframework: String
    public let version: String
    public let outputDirectory: String
    public let variants: [V]

    public init(
        xcframework: String,
        version: String,
        outputDirectory: String
    ) {
        self.xcframework = xcframework
        self.version = version
        self.outputDirectory = outputDirectory

        let xcframeworkURL = URL(fileURLWithPath: xcframework)
        let metadata = try! XCFrameworkMetadata.parse(from: xcframeworkURL)
        self.variants = metadata.variants(for: xcframeworkURL)
        self.target = metadata.libraries.first?.target ?? "Unknown"
    }
}