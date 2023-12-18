import Foundation

public enum DependencyType {
    case cached
    case newCached
    case new
    case automatic
}

public final class DependenciesContainer {

    private static var dependenciesContainer: Dictionary<String, () -> Any> = .init()
    public static private(set) var cache: Dictionary<String, Any> = .init()

    public static func register<Dependency>(type: Dependency.Type,
                                            _ factory: @autoclosure @escaping () -> Dependency) {
        dependenciesContainer[String(describing: type.self)] = factory
    }

    public static func resolve<Dependency>(_ resolveType: DependencyType = .automatic,
                                           _ type: Dependency.Type) -> Dependency? {
        let dependencyName: String = .init(describing: type.self)

        switch resolveType {
        case .cached:
            if let dependency = cache[dependencyName] as? Dependency {
                return dependency
            } else {
                let dependency = dependenciesContainer[dependencyName]?() as? Dependency

                if let dependency {
                    cache[dependencyName] = dependency
                }

                return dependency
            }
        case .newCached:
            let dependency = dependenciesContainer[dependencyName]?() as? Dependency

            if let dependency {
                cache[dependencyName] = dependency
            }

            return dependency
        case .automatic:
            fallthrough
        case .new:
            return dependenciesContainer[dependencyName]?() as? Dependency
        }
    }

    public static func removeAllDependencies() {
        dependenciesContainer.removeAll()
    }

    public static func emptyCache() {
        cache.removeAll()
    }
}
