import Foundation

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
