public enum RoverType: CaseIterable {
    case curiosity(Array<RoverCameraAbbreviation> = [.fhaz, .rhaz, .mast, .chemcam, .mahli, .mardi, .navcam])
    case opportunity(Array<RoverCameraAbbreviation> = [.fhaz, .rhaz, .navcam, .pancam, .minites])
    case spirit(Array<RoverCameraAbbreviation> = [.fhaz, .rhaz, .navcam, .pancam, .minites])

    public var name: String {
        switch self {
        case .curiosity:
            return "Curiosity"
        case .opportunity:
            return "Opportunity"
        case .spirit:
            return "Spirit"
        }
    }

    public static var allCases: Array<RoverType> {
        [.curiosity(), .opportunity(), .spirit()]
    }
}
