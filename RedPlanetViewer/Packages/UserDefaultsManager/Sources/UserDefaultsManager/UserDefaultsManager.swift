import Foundation

@propertyWrapper
public struct UserDefaultsManager<T> {
    private let key: UserDefaultKey
    private let defaultValue: T

    public init(
        _ key: UserDefaultKey,
        defaultValue: T
    ) {
        self.key = key
        self.defaultValue = defaultValue
    }

    public var wrappedValue: T {
        get {
            UserDefaults.standard.object(forKey: key.rawValue) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key.rawValue)
        }
    }

    public func removeObject() {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }

    public func resetToDefault() {
        UserDefaults.standard.set(defaultValue, forKey: key.rawValue)
    }
}
