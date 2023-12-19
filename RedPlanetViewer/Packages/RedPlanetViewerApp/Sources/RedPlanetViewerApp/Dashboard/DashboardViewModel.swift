import Commons
import DependencyInjection
import SwiftUI
import NasaAPIService
import SecretsManager


public final class DashboardViewModel: ObservableObject {
    @Injected private var nasaService: NasaAPIService
    @Injected private var secretsManager: SecretsManager
    @Published var loading: Bool = false
    @Published var roverName: String = "Curiosity"
    @Published var selectedDate: Date = .init()
    @Published var photos: MarsPhotos = .init(photos: .init())

    public init() {}

    @MainActor
    func fetchPhotos() async {
        loading = true
        do {
            photos = try await nasaService.getPhotosFromRover(
                using: .init(
                    roverName: roverName,
                    date: selectedDate.toString(),
                    apiKey: secretsManager.loadFromSecrets(using: .apiKey) ?? .init()
                )
            )
            loading = false
        } catch {
            loading = false
        }
    }
}
