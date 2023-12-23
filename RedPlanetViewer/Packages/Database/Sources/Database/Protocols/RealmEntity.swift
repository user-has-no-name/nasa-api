import Foundation

public protocol RealmEntity {
    associatedtype EntityType

    init(_ entity: EntityType)
    var entity: EntityType { get }
}

public protocol Repository {
    associatedtype EntityType

    func getAll() -> Array<EntityType>
    func getAll(forPage pageNumber: Int, with predicate: NSPredicate) -> Array<EntityType>
    func getItem(by id: UUID) -> EntityType?
    func insert(item: EntityType) async throws
    func remove(item: EntityType) async throws
}
