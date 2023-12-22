public struct MarsPhotos: Decodable {
    public var photos: Array<RoverPhoto>

    public init(photos: Array<RoverPhoto>) {
        self.photos = photos
    }
}
