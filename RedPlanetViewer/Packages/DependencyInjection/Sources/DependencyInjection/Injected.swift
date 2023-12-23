import Foundation

@propertyWrapper
public struct Injected<Dependency> {
    private var dependency: Dependency

    public init(_ type: DependencyType = .automatic) {
        guard let dependency: Dependency = DependenciesContainer.resolve(type, Dependency.self) else {
            let dependencyName: String = .init(describing: Dependency.self)
            fatalError("No service of type \(dependencyName) registered!")
        }
        self.dependency = dependency
    }

    public var wrappedValue: Dependency {
        get { self.dependency }
        mutating set { dependency = newValue }
    }
}
