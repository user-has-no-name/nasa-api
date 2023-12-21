import Kingfisher
import SwiftUI

public struct KFImage: View {
    private let url: URL?
    private let processor: DownsamplingImageProcessor = .init(
        size: .init(
            width: 130.0,
            height: 130.0
        )
    )

    public init(url: URL?) {
        // to cache only on disk
        ImageCache.default.memoryStorage.config.totalCostLimit = 1
        self.url = url
    }

    public var body: some View {
        Kingfisher.KFImage.url(url)
            .placeholder({
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.layerTwo)
            })
            .setProcessor(processor)
            .loadDiskFileSynchronously()
            .targetCache(.default)
            .diskCacheExpiration(.days(7))
            .fade(duration: 0.25)
            .resizable()
            .scaledToFill()
            .frame(width: 130.0, height: 130.0)
            .cornerRadius(20.0)
            .clipped()
    }
}
