import SwiftUI

public struct FullScreenImageView: View {
    @State private var scale: CGFloat = 1.0
    @State private var offset = CGSize.zero
    
    private let imageURL: URL?
    private let closeAction: () -> Void

    public init(
        imageURL: URL?,
        onCloseTappedAction: @escaping () -> Void
    ) {
        self.imageURL = imageURL
        self.closeAction = onCloseTappedAction
    }

    public var body: some View {
        ZStack {
            Color.layerOne.ignoresSafeArea()
            CachedAsyncImage(
                url: imageURL,
                urlCache: .imageCache,
                content: { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(scale)
                        .offset(x: offset.width, y: offset.height)

                }, placeholder: {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.layerTwo)
                        .scaledToFit()
                })
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            offset = gesture.translation
                        }
                )
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            scale = value.magnitude
                        }
                )
                .onTapGesture(count: 2) {
                    reset()
                }
        }
        .overlay(alignment: .topLeading) {
            Button {
                closeAction()
            } label: {
                Image(named: .lightCloseIcon)
            }
            .padding(.leading, 20.0)
        }
    }

    private func reset() {
        scale = 1.0
        offset = .zero
    }
}
