public struct FullFlowConfiguration: Configuration {
    public typealias V = FullFlowVariant

    public let target: String
    public let version: String
    public let outputDirectory: String
    public let variants: [V]
    public let buildDirectory: String
    public let packageDirectory: String

    public init(
        target: String,
        version: String,
        outputDirectory: String,
        variants: [V],
        buildDirectory: String,
        packageDirectory: String
    ) {
        self.target = target
        self.version = version
        self.outputDirectory = outputDirectory
        self.variants = variants
        self.buildDirectory = buildDirectory
        self.packageDirectory = packageDirectory
    }
}