import SwiftUI
import Design

public struct CardView: View {
    private let image: Image
    private let model: CardViewModel

    public var body: some View {
        buildContent()
    }

    public init(
        image: Image,
        model: CardViewModel
    ) {
        self.image = image
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
            RoundedRowImage(image)
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
        image: .init(named: .marsTest),
        model: .init(
            rover: "Curiosity",
            camera: "Front Hazard Avoidance Camera",
            date: "June 6, 2019"
        )
    )
    .padding(24.0)
}
