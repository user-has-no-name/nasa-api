import Kingfisher
import SwiftUI

public struct KFImage: View {
    private let url: URL?

    public init(url: URL?) {
        self.url = url
    }

    public var body: some View {
        Kingfisher.KFImage.url(url)
            .placeholder({
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.layerTwo)
            })
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .resizable()
            .scaledToFill()
//            .aspectRatio(contentMode: .fill)
            .frame(width: 130.0, height: 130.0)
            .cornerRadius(20.0)
            .clipped()
    }
}
