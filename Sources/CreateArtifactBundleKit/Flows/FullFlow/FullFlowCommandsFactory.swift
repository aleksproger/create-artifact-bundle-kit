struct FullFlowCommandsFactory: CommandsFactory {
    typealias Configuration = FullFlowConfiguration

    private let universalBinaryFactory: UniversalBinaryFactory

    init(_ universalBinaryFactory: UniversalBinaryFactory) {
        self.universalBinaryFactory = universalBinaryFactory
    }

    func make(for configuration: FullFlowConfiguration) -> [Command] {[
        DeleteCurrentArtifactBundleDirectoryIfExist(configuration),
        CreateArtifactBundleDirectories(configuration),
        CleanBuildAllVariants(configuration),
        CreateUniversalBinary(configuration, universalBinaryFactory),
        CreateMetadataFile(configuration),
    ]}
}