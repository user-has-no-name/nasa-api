import Foundation
import RealmSwift

public class RoverPhotoEntity: Object, RealmEntity {
    public typealias EntityType = RoverPhoto

    @Persisted(primaryKey: true) var _id: Int
    @Persisted var rover: String
    @Persisted var camera: String
    @Persisted var date: Date
    @Persisted var imgSrc: String

    public override init() {}

    public required init(_ entity: RoverPhoto) {
        super.init()
        self._id = entity.id
        self.rover = entity.rover.name
        self.camera = entity.camera.fullName
        self.date = entity.earthDate.toDate(format: .api) ?? .init()
        self.imgSrc = entity.imgSrc
    }

    public var entity: RoverPhoto {
        .init(
            id: _id,
            camera: .init(fullName: camera),
            imgSrc: imgSrc,
            earthDate: date.toString(format: .api),
            rover: .init(name: rover)
        )
    }
}
