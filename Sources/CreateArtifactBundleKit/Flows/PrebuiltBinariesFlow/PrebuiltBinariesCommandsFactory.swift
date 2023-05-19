public struct PrebuiltBinariesCommandsFactory<C: Configuration>: CommandsFactory 
where C.V == PrebuiltBinariesVariant {
    private let universalBinaryFactory: UniversalBinaryFactory

    init(_ universalBinaryFactory: UniversalBinaryFactory) {
        self.universalBinaryFactory = universalBinaryFactory
    }

    public func make(for configuration: C) -> [Command] {[
        DeleteCurrentArtifactBundleDirectoryIfExist(configuration),
        CreateArtifactBundleDirectories(configuration),
        CreateUniversalBinary(configuration, universalBinaryFactory),
        CreateMetadataFile(configuration),
    ]}
}