import Foundation
import RealmSwift

@propertyWrapper
public struct RealmRepositoryWrapper<T>: Repository where T: RealmEntity, T: Object, T.EntityType: Entity {
    typealias RealmEntityType = T

    private var repository: RealmRepository<T>

    public var wrappedValue: RealmRepository<T> {
        repository
    }

    public init() {
        repository = RealmRepository<T>()
    }

    public func insert(item: T.EntityType) throws {
        try repository.insert(item: item)
    }

    public func getAll() -> Array<T.EntityType> {
        repository.getAll()
    }

    public func getItem(by id: UUID) -> T.EntityType? {
        repository.getItem(by: id)
    }

    public func remove(item: T.EntityType) throws {
        try repository.remove(item: item)
    }
}
