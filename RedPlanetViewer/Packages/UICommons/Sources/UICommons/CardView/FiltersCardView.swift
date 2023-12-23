import SwiftUI

public struct FiltersCardView: View {
    private let model: CardViewModel

    public init(
        model: CardViewModel
    ) {
        self.model = model
    }

    public var body: some View {
        buildContent()
    }

    private func buildContent() -> some View {
        VStack(
            alignment: .leading,
            spacing: 6
        ) {
            HStack(
                alignment: .center,
                spacing: 6
            ) {
                Rectangle()
                    .fill(Color.accentOne)
                    .frame(maxWidth: .infinity, maxHeight: 1.0)

                Text("Filters")
                    .foregroundColor(.accentOne)
                    .font(.system(size: 22, weight: .bold))
            }
            LabelRowsView(model: model)
        }
            .padding([.leading, .bottom, .trailing], 16.0)
            .padding(.top, 10.0)
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
    FiltersCardView(
        model: .init(
            rover: "Curiosity",
            camera: "Front Hazard Avoidance Camera",
            date: "June 6, 2019"
        )
    )
    .padding(24.0)
}
