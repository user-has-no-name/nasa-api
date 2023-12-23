import Database
import DependencyInjection
import NasaAPIService
import SecretsManager

public extension DependenciesContainer {

    static func registerDependencies() {
        register(type: NasaAPIService.self, NasaAPIService())
        register(type: SecretsManager.self, SecretsManager())
        
        register(type: RealmRepository<RoverPhotoEntity>.self, RealmRepository<RoverPhotoEntity>())
        register(type: RealmRepository<FilterEntity>.self, RealmRepository<FilterEntity>())
    }
}
