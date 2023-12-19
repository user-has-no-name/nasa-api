import Foundation

public struct Rover: Decodable, Identifiable {
    public let id: Int
    public let name: String
    public let landingDate: String
    public let launchDate: String
    public let status: String
    public let maxSol: Int
    public let maxDate: String
    public let totalPhotos: Int
    public let cameras: Array<RoverCamera>

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case status
        case maxSol = "max_sol"
        case maxDate = "max_date"
        case totalPhotos = "total_photos"
        case cameras
    }
}
