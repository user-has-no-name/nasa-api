import Foundation

public extension URLCache {

    static let imageCache: URLCache = .init(
        memoryCapacity: 100_000_000,
        diskCapacity: 10_000_000_000
    )
}
