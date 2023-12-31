import Foundation

public protocol NetworkClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint) async throws -> T
}

public extension NetworkClient {

    func sendRequest<T: Decodable>(endpoint: Endpoint) async throws -> T {
        guard let url: URL = endpoint.buildURL() else { throw NetworkError.invalidURL }

        var request: URLRequest = .init(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header

        if let body: Dictionary<String, String> = endpoint.body {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        }
        
        let (data, response): (Data, URLResponse) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.noResponse
        }

        switch response.statusCode {
        case 200...299:
            let decodedResponse: T = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        case 401:
            throw NetworkError.unauthorized
        default:
            throw NetworkError.unexpectedStatusCode
        }
    }
}
