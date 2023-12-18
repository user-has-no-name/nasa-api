import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: Dictionary<String, String>? { get }
    var body: Dictionary<String, String>? { get }
    var queryItems: Array<URLQueryItem>? { get }
}

extension Endpoint {

    func buildURL() -> URL? {
        return PathBuilder.buildURL(for: self)
    }
}
