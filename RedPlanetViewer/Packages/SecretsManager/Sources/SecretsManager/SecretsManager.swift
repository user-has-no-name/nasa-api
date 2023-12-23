import Foundation

public struct SecretsManager {
    public func loadFromSecrets(
        using key: SecretKey
    ) -> String? {
        guard let path: String = Bundle.module.path(forResource: "secrets", ofType: "json"),
              let data: Data = try? .init(contentsOf: URL(fileURLWithPath: path)),
              let secrets: Dictionary<String, Any> = try? JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String, Any>,
              let apiKey: String = secrets[key.rawValue] as? String else {
            return nil
        }
        return apiKey
    }

    public init() {}
}
