import Foundation
import RealmSwift

public struct Filter: Entity, Hashable, Identifiable, Codable {
    public var id: UUID
    public var rover: RoverType
    public var camera: RoverCameraAbbreviation
    public var date: Date

    public init(
        id: UUID,
        rover: RoverType,
        camera: RoverCameraAbbreviation,
        date: Date
    ) {
        self.id = id
        self.rover = rover
        self.camera = camera
        self.date = date
    }
}

public extension Filter {

    static func `default`() -> Self {
        .init(
            id: .init(),
            rover: .curiosity,
            camera: .all,
            date: .init()
        )
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
        self.rover = entity.rover.abbreviation
        self.camera = entity.camera.abbreviation
        self.date = entity.date
    }

    public var entity: Filter {
        .init(
            id: _id,
            rover: .init(rawValue: rover) ?? .curiosity,
            camera: .init(rawValue: camera) ?? .all,
            date: date
        )
    }
}
