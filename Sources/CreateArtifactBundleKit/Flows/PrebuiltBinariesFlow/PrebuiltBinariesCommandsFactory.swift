struct PrebuiltBinariesCommandsFactory: CommandsFactory {
    typealias Configuration = PrebuiltBinariesConfiguration

    private let universalBinaryFactory: UniversalBinaryFactory

    init(_ universalBinaryFactory: UniversalBinaryFactory) {
        self.universalBinaryFactory = universalBinaryFactory
    }

    func make(for configuration: PrebuiltBinariesConfiguration) -> [Command] {[
        DeleteCurrentArtifactBundleDirectoryIfExist(configuration),
        CreateArtifactBundleDirectories(configuration),
        CreateUniversalBinary(configuration, universalBinaryFactory),
        CreateMetadataFile(configuration),
    ]}
}