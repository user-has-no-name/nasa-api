import Commons

public enum RoverType: String, Pickable {
    case curiosity = "Curiosity"
    case opportunity = "Opportunity"
    case spirit = "Spirit"

    public static var defaultValue: RoverType { .curiosity }
    public var id: Self { self }
    public var abbreviation: String {
        switch self {
        case .curiosity:
            return "curiosity"
        case .opportunity:
            return "opportunity"
        case .spirit:
            return "spirit"
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
