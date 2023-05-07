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
        variants: [String: Set<String>],
        buildDirectory: String,
        packageDirectory: String
    ) {
        self.target = target
        self.version = version
        self.outputDirectory = outputDirectory
        self.variants = variants.map { name, triples in
            let binaries = binariesAfterBuild(target: target, triples: triples, buildDirectory: buildDirectory)
            return V(name: name, triples: triples, binaries: binaries)
        }
        self.buildDirectory = buildDirectory
        self.packageDirectory = packageDirectory
    }
}

private func binariesAfterBuild(
    target: String,
    triples: Set<String>,
    buildDirectory: String
) -> [Binary] {
    triples.map { triple in
        Binary(triple: triple, path:  "\(buildDirectory)/\(triple)/release/\(target)")
    }
}