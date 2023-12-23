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
            var items: Array<URLQueryItem> = .init()
            
            if let page: String = configuration.page {
                items.append(
                    .init(name: "page", value: page)
                )
            }

            if let camera: String = configuration.camera, camera.lowercased() != "all" {
                items.append(
                    .init(name: "camera", value: camera)
                )
            }

            items.append(contentsOf: [
                .init(name: "earth_date", value: configuration.date),
                .init(name: "api_key", value: configuration.apiKey)
            ])

            return items
        }
    }
}
