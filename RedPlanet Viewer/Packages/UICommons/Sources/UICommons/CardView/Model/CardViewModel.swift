public struct CardViewModel {
    public let rover: String
    public let camera: String
    public let date: String
}

public enum LabelRowType: String, CaseIterable {
    case rover, camera, date
}
