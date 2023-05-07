public enum Kits {
    public static func fullFlow(
        universalBinaryFactory: UniversalBinaryFactory
    ) -> some FullFlowKit {
        CreateArtifactBundleKit(
            commandsFactory: FullFlowCommandsFactory(universalBinaryFactory)
        )
    }

    public static func prebuiltBinariesFlow(
        universalBinaryFactory: UniversalBinaryFactory
    ) -> some PrebuiltBinariesKit {
        CreateArtifactBundleKit(
            commandsFactory: PrebuiltBinariesCommandsFactory(universalBinaryFactory)
        )
    }
}