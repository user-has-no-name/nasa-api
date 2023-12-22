import Foundation
import RealmSwift

public struct Filter: Entity, Hashable, Identifiable {
    public var id: UUID
    public var rover: String
    public var camera: String
    public var date: Date

    public init(
        id: UUID,
        rover: String,
        camera: String,
        date: Date
    ) {
        self.id = id
        self.rover = rover
        self.camera = camera
        self.date = date
    }
}

public class FilterEntity: Object, RealmEntity {
    public typealias EntityType = Filter

    @Persisted(primaryKey: true) var _id: UUID
    @Persisted var rover: String
    @Persisted var camera: String
    @Persisted var date: Date

    public override init() {}

    public required init(_ entity: Filter) {
        super.init()
        self._id = entity.id
        self.rover = entity.rover
        self.camera = entity.camera
        self.date = entity.date
    }

    public var entity: Filter {
        .init(
            id: _id,
            rover: rover,
            camera: camera,
            date: date
        )
    }
}
