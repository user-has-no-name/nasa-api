import Networking

public protocol NasaAPIServiceable {
    func getPhotosFromRover(using configuration: RoverPhotosEndpointConfiguration) async throws -> MarsPhotos
}

public struct NasaAPIService: NetworkClient, NasaAPIServiceable {
    public init() { }

    public func getPhotosFromRover(using configuration: RoverPhotosEndpointConfiguration) async throws -> MarsPhotos {
        try await sendRequest(endpoint: RoverPhotosEndpoint.photos(configuration))
    }
}
