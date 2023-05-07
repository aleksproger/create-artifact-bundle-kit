public protocol FullFlowKit {
    func run(with configuration: FullFlowConfiguration) async throws
}

extension CreateArtifactBundleKit: FullFlowKit where Config == FullFlowConfiguration {}
