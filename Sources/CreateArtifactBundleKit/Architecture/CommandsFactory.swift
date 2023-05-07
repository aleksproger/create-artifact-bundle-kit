public protocol CommandsFactory {
    associatedtype Configuration

    func make(for configuration: Configuration) -> [Command]
}