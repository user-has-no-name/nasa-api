import Commons

public enum RoverType: String, Pickable {
    case curiosity
    case opportunity
    case spirit

    public static var defaultValue: RoverType { .curiosity }
    public var id: Self { self }
    public var fullName: String {
        switch self {
        case .curiosity:
            return "Curiosity"
        case .opportunity:
            return "Opportunity"
        case .spirit:
            return "Spirit"
        }
    }
    public var availableCameras: Array<RoverCameraAbbreviation> {
        switch self {
        case .curiosity:
            return [.all, .fhaz, .rhaz, .mast, .chemcam, .mahli, .mardi, .navcam]
        case .opportunity:
            return [.all, .fhaz, .rhaz, .navcam, .pancam, .minites]
        case .spirit:
            return [.all, .fhaz, .rhaz, .navcam, .pancam, .minites]
        }
    }
}
