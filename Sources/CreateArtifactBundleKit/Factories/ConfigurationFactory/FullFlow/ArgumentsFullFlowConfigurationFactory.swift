public final class ArgumentsFullFlowConfigurationFactory: ConfigurationFactory {
    public typealias Description = Arguments
    public typealias Configuration = FullFlowConfiguration

    public init() {}

    public func make(from arguments: Arguments) throws -> FullFlowConfiguration {
        if arguments.value.count < 4 {
            print("ArgumentsConfigurationError: Expected create-artifact-bundle <target> <version> <rootDirectory> [<triple>]")
            throw ArgumentsConfigurationError.tooFewArguments
        }

        let target = arguments.value[0]
        let version = arguments.value[1]
        let rootDirectory = arguments.value[2]

        let triples = (3..<arguments.value.count).reduce([]) { result, i in
            result + [arguments.value[i]]
        }

        return FullFlowConfiguration(
            target: target,
            version: version,
            triples: Set(triples),
            rootDirectory: rootDirectory,
            buildDirectory: "\(rootDirectory)/.build"
        )
    }
}

enum ArgumentsConfigurationError: Error {
    case tooFewArguments
}