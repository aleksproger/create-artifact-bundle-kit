import Foundation

public struct XCFrameworkMetadata: Equatable {
    public struct Library: Equatable {
        public let libraryIdentifier: String
        public let libraryPath: String
        public let headersPath: String?
        public let platform: String
        public let platformVariant: String?
        public let architectures: [String]

        public init(
            libraryIdentifier: String,
            libraryPath: String,
            headersPath: String?,
            platform: String,
            platformVariant: String?,
            architectures: [String]
        ) {
            self.libraryIdentifier = libraryIdentifier
            self.libraryPath = libraryPath
            self.headersPath = headersPath
            self.platform = platform
            self.platformVariant = platformVariant
            self.architectures = architectures
        }
    }

    public let libraries: [Library]

    public init(libraries: [Library]) {
        self.libraries = libraries
    }
}

extension XCFrameworkMetadata: Decodable {
    enum CodingKeys: String, CodingKey {
        case libraries = "AvailableLibraries"
    }
}

extension XCFrameworkMetadata.Library: Decodable {
    enum CodingKeys: String, CodingKey {
        case libraryIdentifier = "LibraryIdentifier"
        case libraryPath = "LibraryPath"
        case headersPath = "HeadersPath"
        case platform = "SupportedPlatform"
        case platformVariant = "SupportedPlatformVariant"
        case architectures = "SupportedArchitectures"
    }
}

extension XCFrameworkMetadata {
    public static func parse(from path: URL) throws -> XCFrameworkMetadata {
        let infoPlistPath = path.appendingPathComponent("Info.plist")

        guard FileManager.default.fileExists(atPath: infoPlistPath.path) else {
            throw XCFrameworkMetadataError.infoPlistNotFound
        }

        do {
            let data = try Data(contentsOf: infoPlistPath)
            let decoder = PropertyListDecoder()
            return try decoder.decode(XCFrameworkMetadata.self, from: data)
        } catch {
            throw XCFrameworkMetadataError.unableToParsePlist
        }
    }
}

extension XCFrameworkMetadata.Library {
    var target: String {
        (libraryPath as NSString).deletingPathExtension
    }

    var osAndVariant: String {
        if let varint = platformVariant {
            return "\(platform)-\(varint)"
        } else {
            return "\(platform)"
        }
    }

    var triples: [String] {
        architectures.map { architecture in
            "\(architecture)-apple-\(osAndVariant)"
        }
    }

    func binaryPath(_ xcframeworkPath: URL) -> URL {
        xcframeworkPath.appendingPathComponent("\(libraryIdentifier)/\(libraryPath)/\(target)")
    }
}

extension XCFrameworkMetadata {
    func variants(for xcframeworkPath: URL) -> [PrebuiltBinariesVariant] {
        libraries.map { library in
            PrebuiltBinariesVariant(
                name: "\(library.target)-\(library.osAndVariant)",
                binaries: [
                    Binary(triples: library.triples, path: library.binaryPath(xcframeworkPath).path)
                ]
            )
        }
    }
}

private enum XCFrameworkMetadataError: Error {
    case infoPlistNotFound
    case unableToParsePlist
}