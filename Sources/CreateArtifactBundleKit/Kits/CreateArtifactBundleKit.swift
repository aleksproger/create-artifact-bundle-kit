import Foundation

public struct CreateArtifactBundleKit<Config: Configuration, CmdFactory: CommandsFactory>
where Config == CmdFactory.Configuration {
    private let commandsFactory: CmdFactory

    public init(commandsFactory: CmdFactory) {
        self.commandsFactory = commandsFactory
    }

    public func run(with configuration: Config) async throws {
        let commands = commandsFactory.make(for: configuration)
        try await commands.execute()
    }
}