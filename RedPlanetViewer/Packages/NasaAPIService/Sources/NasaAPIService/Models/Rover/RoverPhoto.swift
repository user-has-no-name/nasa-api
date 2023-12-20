public struct RoverPhoto: Decodable {
    public let id: Int
    public var sol: Int?
    public let camera: Camera
    public let imgSrc: String
    public var earthDate: String
    public let rover: Rover

    enum CodingKeys: String, CodingKey {
        case id
        case camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
}
