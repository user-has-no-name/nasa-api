import SwiftUI
import Design

public struct CardView: View {
    private let imageURL: URL?
    private let model: CardViewModel
    private let onImageTapAction: () -> Void

    public var body: some View {
        buildContent()
    }

    public init(
        imageURL: URL?,
        model: CardViewModel,
        onImageTapAction: @escaping () -> Void
    ) {
        self.imageURL = imageURL
        self.model = model
        self.onImageTapAction = onImageTapAction
    }

    #warning("Extract shadow into separate view modifier")
    private func buildContent() -> some View {
        HStack(
            alignment: .center,
            spacing: 10
        ) {
            LabelRowsView(
                model: model,
                lineLimitForCamera: 2
            )

            CachedAsyncImage(
                url: imageURL,
                urlCache: .imageCache,
                content: { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 130.0, height: 130.0)
                    .cornerRadius(20.0)
                    .clipped()
                },
                placeholder: {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.layerTwo)
                        .frame(width: 130.0, height: 130.0)
                })
            .onTapGesture {
                onImageTapAction()
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.leading, 16.0)
        .padding([.top, .bottom, .trailing], 10.0)
        .background(
            RoundedRectangle(cornerRadius: 30.0)
                .fill(Color.backgroundOne)
                .shadow(
                    color: .layerOne.opacity(0.08),
                    radius: 8,
                    x: 0, y: 3
                )
        )
    }
}
