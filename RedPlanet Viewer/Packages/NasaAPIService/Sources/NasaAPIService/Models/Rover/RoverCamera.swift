public struct RoverCamera: Decodable {
    public let name: String
    public let fullName: String

    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
    }
}
