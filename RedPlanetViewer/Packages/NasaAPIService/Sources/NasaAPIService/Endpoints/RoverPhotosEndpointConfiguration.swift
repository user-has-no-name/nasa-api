public struct RoverPhotosEndpointConfiguration {
    public let roverName: String
    public let date: String
    public let camera: String?
    public let page: String?
    public let apiKey: String

    public init(
        roverName: String,
        date: String,
        camera: String? = nil,
        page: String? = nil,
        apiKey: String
    ) {
        self.roverName = roverName
        self.date = date
        self.camera = camera
        self.page = page
        self.apiKey = apiKey
    }
}
