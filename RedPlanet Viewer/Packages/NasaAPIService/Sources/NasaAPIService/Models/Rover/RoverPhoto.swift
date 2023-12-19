public struct RoverPhoto: Decodable {
    public let id: Int
    public let sol: Int
    public let camera: Camera
    public let imgSrc: String
    public let earthDate: String
    public let rover: Rover

    enum CodingKeys: String, CodingKey {
        case id
        case sol
        case camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
}
