public struct Camera: Decodable {
    public var name: String?
    public var roverId: Int?
    public let fullName: String

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
    }
}
