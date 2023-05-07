import Foundation

public struct CreateArtifactBundleKit<Description, ConfigFactory: ConfigurationFactory, CmdFactory: CommandsFactory>
where Description == ConfigFactory.Description, ConfigFactory.Configuration == CmdFactory.Configuration {
    private let configurationFactory: ConfigFactory
    private let commandsFactory: CmdFactory

    public init(
        configurationFactory: ConfigFactory,
        commandsFactory: CmdFactory
    ) {
        self.configurationFactory = configurationFactory
        self.commandsFactory = commandsFactory
    }

    public func run(with description: Description) async throws {
        let configuration = try configurationFactory.make(from: description)
        let commands = commandsFactory.make(for: configuration)
        try await commands.execute()
    }
}