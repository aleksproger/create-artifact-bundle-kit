public enum Kits {
    public static func fullFlow(
        universalBinaryFactory: UniversalBinaryFactory = LipoBinaryFactory()
    ) -> some FullFlowKit {
        CreateArtifactBundleKit(
            commandsFactory: FullFlowCommandsFactory(universalBinaryFactory)
        )
    }

    public static func prebuiltBinariesFlow(
        universalBinaryFactory: UniversalBinaryFactory = LipoBinaryFactory()
    ) -> some PrebuiltBinariesKit {
        CreateArtifactBundleKit(
            commandsFactory: PrebuiltBinariesCommandsFactory(universalBinaryFactory)
        )
    }
}