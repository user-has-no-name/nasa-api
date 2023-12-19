import Foundation
import Networking

enum RoverPhotosEndpoint {
    case photos(RoverPhotosEndpointConfiguration)
}

extension RoverPhotosEndpoint: Endpoint {

    var path: String {
        switch self {
        case let .photos(configuration):
            return "/mars-photos/api/v1/rovers/\(configuration.roverName)/photos"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .photos:
            return .get
        }
    }

    var queryItems: Array<URLQueryItem>? {
        switch self {
        case let .photos(configuration):
            return [
                .init(name: "earth_date", value: configuration.date),
                .init(name: "camera", value: configuration.camera),
                .init(name: "page", value: configuration.page),
                .init(name: "api_key", value: configuration.apiKey)
            ]
        }
    }
}
