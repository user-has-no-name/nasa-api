public struct MarsPhotos: Decodable {
    public let photos: Array<RoverPhoto>

    public init(photos: Array<RoverPhoto>) {
        self.photos = photos
    }
}
