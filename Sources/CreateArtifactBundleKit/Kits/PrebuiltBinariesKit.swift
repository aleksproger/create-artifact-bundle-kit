public protocol PrebuiltBinariesKit {
    func run(with configuration: PrebuiltBinariesConfiguration) async throws
}

// extension CreateArtifactBundleKit: PrebuiltBinariesKit where Config.V == PrebuiltBinariesVariant {}
