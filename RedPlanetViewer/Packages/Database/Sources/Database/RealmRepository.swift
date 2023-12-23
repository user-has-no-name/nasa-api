import Foundation
import RealmSwift

public final class RealmRepository<T>: Repository where T: RealmEntity, T: Object, T.EntityType: Entity {
    typealias RealmEntityType = T

    private let realm: Realm = try! .init()

    @MainActor
    public func insert(item: T.EntityType) async throws {
        try await realm.asyncWrite {
            realm.add(RealmEntityType(item))
        }
    }

    @MainActor
    public func getAll() -> Array<T.EntityType> {
        realm.objects(T.self)
            .compactMap { $0.entity }
    }

    @MainActor
    public func getAll(
        forPage pageNumber: Int,
        with predicate: NSPredicate
    ) -> Array<T.EntityType> {
        let objects: Results<T> = realm.objects(T.self).filter(predicate)
        let numberOfObjects: Int = objects.count
        let itemsPerPage: Int = 25

        guard pageNumber > 0 else {
            return .init()
        }

        let lowerBound: Int = (pageNumber - 1) * itemsPerPage
        let upperBound: Int = min(pageNumber * itemsPerPage, numberOfObjects)

        guard lowerBound < numberOfObjects else {
            return .init()
        }

        let objectsInRange: Slice<Results<T>> = objects[lowerBound..<upperBound]
        return objectsInRange.map{ $0.entity }
    }

    @MainActor
    public func remove(item: T.EntityType) async throws {
        let objectToDelete: Results<T> = try await Realm()
            .objects(T.self)
            .filter("_id=%@", item.id)

        try await realm.asyncWrite {
            realm.delete(objectToDelete)
        }
    }

    @MainActor
    public func getItem(by id: UUID) -> T.EntityType? {
        realm.object(ofType: T.self, forPrimaryKey: id)?.entity
    }

    public init() {}
}
