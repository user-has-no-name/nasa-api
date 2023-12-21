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
            .targetCache(.init(name: "diskCache"))
            .memoryCacheExpiration(.never)
            .diskCacheExpiration(.days(7))
            .fade(duration: 0.25)
            .resizable()
            .scaledToFill()
            .frame(width: 130.0, height: 130.0)
            .cornerRadius(20.0)
            .clipped()
    }
}
