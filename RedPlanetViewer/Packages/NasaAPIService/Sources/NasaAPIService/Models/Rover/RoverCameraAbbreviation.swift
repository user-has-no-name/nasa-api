import Commons
import Foundation

public enum RoverCameraAbbreviation: String, Pickable {
    case all = "All"
    case fhaz = "Front Hazard Avoidance Camera"
    case rhaz = "Rear Hazard Avoidance Camera"
    case mast = "Mast Camera"
    case chemcam = "Chemistry and Camera Complex"
    case mahli = "Mars Hand Lens Imager"
    case mardi = "Mars Descent Imager"
    case navcam = "Navigation Camera"
    case pancam = "Panoramic Camera"
    case minites = "Miniature Thermal Emission Spectrometer (Mini-TES)"

    public var id: Self { self }
    public static var defaultValue: RoverCameraAbbreviation = .all
    public var abbreviation: String {
        switch self {
        case .fhaz:
            return "fhaz"
        case .rhaz:
            return "rhaz"
        case .mast:
            return "mast"
        case .chemcam:
            return "chemcam"
        case .mahli:
            return "mahli"
        case .mardi:
            return "mardi"
        case .navcam:
            return "navcam"
        case .pancam:
            return "pancam"
        case .minites:
            return "minites"
        case .all:
            return "all"
        }
    }
}
