import Foundation

struct PathBuilder {

    static func buildURL(for endpoint: Endpoint) -> URL? {
        var urlComponents: URLComponents = .init()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems

        return urlComponents.url
    }
}
