public enum Kits {
    public static func fullFlowFromArguments(
        universalBinaryFactory: UniversalBinaryFactory
    ) -> some ArgumentsBasedKit {
        CreateArtifactBundleKit(
            configurationFactory: ArgumentsFullFlowConfigurationFactory(),
            commandsFactory: FullFlowCommandsFactory(universalBinaryFactory)
        )
    }
}