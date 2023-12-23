import Foundation

public struct Configuration {
    public struct File {
        internal let filename: String
        internal let bundle: Bundle

        internal init(
            filename: String,
            bundle: Bundle
        ) {
            self.filename = filename
            self.bundle = bundle
        }
    }

    public let lightMode: File
    public let darkMode: File

    internal init(
        lightMode: File,
        darkMode: File
    ) {
        self.lightMode = lightMode
        self.darkMode = darkMode
    }
}

public extension Configuration {

    static let loader: Self = .init(
        lightMode: .init(
            filename: "loader.json",
            bundle: .module
        ),
        darkMode: .init(
            filename: "loader.json",
            bundle: .module
        )
    )
}
