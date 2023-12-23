import Foundation
import RealmSwift

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
        self.rover = entity.rover.abbreviation
        self.camera = entity.camera.abbreviation
        self.date = entity.date
    }

    public var entity: Filter {
        .init(
            id: _id,
            rover: .init(rawValue: rover) ?? .defaultValue,
            camera: .init(rawValue: camera) ?? .defaultValue,
            date: date
        )
    }
}
