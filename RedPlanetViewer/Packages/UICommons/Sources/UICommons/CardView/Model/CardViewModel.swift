public struct CardViewModel {
    public let rover: String
    public let camera: String
    public let date: String

    public init(
        rover: String,
        camera: String,
        date: String
    ) {
        self.rover = rover
        self.camera = camera
        self.date = date
    }
}

public enum LabelRowType: String, CaseIterable {
    case rover, camera, date
}
