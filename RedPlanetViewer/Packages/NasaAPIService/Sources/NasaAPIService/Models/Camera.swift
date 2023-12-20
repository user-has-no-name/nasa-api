public struct Camera: Decodable, Identifiable {
    public let id: Int
    public var name: String?
    public var roverId: Int?
    public let fullName: String

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
    }
}
