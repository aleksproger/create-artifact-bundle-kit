public protocol ConfigurationFactory {
    associatedtype Description
    associatedtype Configuration

    func make(from: Description) throws -> Configuration
}