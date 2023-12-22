import Foundation
import RealmSwift

public final class RealmRepository<T>: Repository where T: RealmEntity, T: Object, T.EntityType: Entity {
    typealias RealmEntityType = T

    private let realm: Realm = try! .init()

    public func insert(item: T.EntityType) throws {
        try realm.write {
            realm.add(RealmEntityType(item))
        }
    }

    public func getAll() -> Array<T.EntityType> {
        realm.objects(T.self)
            .compactMap { $0.entity }
    }

    public func remove(item: T.EntityType) throws {
        let objectToDelete: Results<T> = try Realm().objects(T.self).filter("_id=%@", item.id)
        try realm.write {
            realm.delete(objectToDelete)
        }
    }

    public func getItem(by id: UUID) -> T.EntityType? {
        realm.object(ofType: T.self, forPrimaryKey: id)?.entity
    }

    public init() {}
}
