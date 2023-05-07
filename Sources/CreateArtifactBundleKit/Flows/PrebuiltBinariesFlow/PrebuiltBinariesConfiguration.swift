public struct PrebuiltBinariesConfiguration: Configuration {
    public typealias V = PrebuiltBinariesVariant

    public let target: String
    public let version: String
    public let outputDirectory: String
    public let variants: [V]

    public init(
        target: String,
        version: String,
        outputDirectory: String,
        variants: [V]
    ) {
        self.target = target
        self.version = version
        self.outputDirectory = outputDirectory
        self.variants = variants
    }
}