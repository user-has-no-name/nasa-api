import Foundation
import Networking
import Database
import DependencyInjection

public protocol NasaAPIServiceable {
    func getPhotos(using configuration: RoverPhotosEndpointConfiguration) async throws -> MarsPhotos
}

public struct NasaAPIService: NetworkClient, NasaAPIServiceable {
    @Injected private var roverPhotosRepository: RealmRepository<RoverPhotoEntity>

    public func getPhotos(using configuration: RoverPhotosEndpointConfiguration) async throws -> MarsPhotos {
        let photosFromCache: MarsPhotos = await prefetchDataFromCacheIfExists(
            .init(
                id: .init(),
                rover: .init(abbreviation: configuration.roverName) ?? .defaultValue,
                camera: .init(abbreviation: configuration.camera ?? .empty) ?? .defaultValue,
                date: configuration.date.toDate(format: .api) ?? .init()
            ),
            page: Int(configuration.page ?? .empty) ?? 0
        )
        guard photosFromCache.photos.isEmpty else {
            return photosFromCache
        }

        let photosFromAPI: MarsPhotos = try await sendRequest(endpoint: RoverPhotosEndpoint.photos(configuration))
        try? await cacheData(photosFromAPI)

        return photosFromAPI
    }

    @MainActor 
    private func prefetchDataFromCacheIfExists(
        _ filter: Filter,
        page: Int
    ) -> MarsPhotos {
        var predicates: Array<NSPredicate> = .init()
        predicates.append(.init(format: "rover = %@", filter.rover.rawValue))

        if filter.camera != .all {
            predicates.append(.init(format: "camera = %@", filter.camera.rawValue))
        }

        predicates.append(.init(format: "date = %@", filter.date as NSDate))
        let predicate: NSCompoundPredicate = .init(andPredicateWithSubpredicates: predicates)

        return .init(photos: roverPhotosRepository.getAll(forPage: page, with: predicate))
    }

    private func cacheData(_ photos: MarsPhotos) async throws {
        for roverPhoto in photos.photos {
            do {
                try await roverPhotosRepository.insert(item: roverPhoto)
            } catch {
                throw error
            }
        }
    }

    public init() { }
}
