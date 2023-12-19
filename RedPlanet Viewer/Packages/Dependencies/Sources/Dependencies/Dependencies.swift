import DependencyInjection
import NasaAPIService
import SecretsManager

public extension DependenciesContainer {

    static func registerDependencies() {
        register(type: NasaAPIService.self, NasaAPIService())
        register(type: SecretsManager.self, SecretsManager())
    }
}
