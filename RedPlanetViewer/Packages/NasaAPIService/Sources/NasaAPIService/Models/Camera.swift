public struct Camera: Decodable, Identifiable {
    public let id: Int
    public let name: String
    public let roverId: Int
    public let fullName: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case roverId = "rover_id"
        case fullName = "full_name"
    }
}
