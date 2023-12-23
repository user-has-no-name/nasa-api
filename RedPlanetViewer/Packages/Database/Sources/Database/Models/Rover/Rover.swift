import Foundation

public struct Rover: Codable {
    public let name: String
    public var landingDate: String?
    public var launchDate: String?
    public var status: String?
    public var maxSol: Int?
    public var maxDate: String?
    public var totalPhotos: Int?
    public var cameras: Array<RoverCamera>?

    enum CodingKeys: String, CodingKey {
        case name
    }
}
