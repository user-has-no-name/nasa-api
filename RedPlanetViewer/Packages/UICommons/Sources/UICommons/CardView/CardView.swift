import SwiftUI
import Design

public struct CardView: View {
    private let imageURL: URL?
    private let model: CardViewModel

    public var body: some View {
        buildContent()
    }

    public init(
        imageURL: URL?,
        model: CardViewModel
    ) {
        self.imageURL = imageURL
        self.model = model
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
            KFImage(url: imageURL)
        }
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

#Preview {
    CardView(
        imageURL: .init(string: "https://media.cnn.com/api/v1/images/stellar/prod/210330140016-curiosity-selfie.jpg?q=w_1480,c_fill"),
        model: .init(
            rover: "Curiosity",
            camera: "Front Hazard Avoidance Camera",
            date: "June 6, 2019"
        )
    )
    .padding(24.0)
}
