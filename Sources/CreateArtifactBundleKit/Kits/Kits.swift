public enum Kits {
    public static func fullFlow(
        universalBinaryFactory: UniversalBinaryFactory = LipoBinaryFactory()
    ) -> some FullFlowKit {
        CreateArtifactBundleKit(
            commandsFactory: FullFlowCommandsFactory(universalBinaryFactory)
        )
    }

    public static func prebuiltBinariesFlow<C: Configuration>(
        universalBinaryFactory: UniversalBinaryFactory = LipoBinaryFactory()
    ) -> CreateArtifactBundleKit<C, PrebuiltBinariesCommandsFactory<C>> 
    where C.V == PrebuiltBinariesVariant {
        CreateArtifactBundleKit(
            commandsFactory: PrebuiltBinariesCommandsFactory(universalBinaryFactory)
        )
    }
}