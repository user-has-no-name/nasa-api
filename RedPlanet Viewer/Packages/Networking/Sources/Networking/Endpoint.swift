import Foundation

public protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: Dictionary<String, String>? { get }
    var body: Dictionary<String, String>? { get }
    var queryItems: Array<URLQueryItem>? { get }
}

public extension Endpoint {

    var header: Dictionary<String, String>? { nil }
    var body: Dictionary<String, String>? { nil }
    var queryItems: Array<URLQueryItem>? { nil }

    func buildURL() -> URL? {
        return PathBuilder.buildURL(for: self)
    }
}
