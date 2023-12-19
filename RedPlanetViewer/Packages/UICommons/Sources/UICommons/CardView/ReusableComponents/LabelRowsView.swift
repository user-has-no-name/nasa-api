import SwiftUI

struct LabelRowsView: View {
    private let model: CardViewModel
    private let lineLimitForCamera: Int

    init(
        model: CardViewModel,
        lineLimitForCamera: Int = 1
    ) {
        self.model = model
        self.lineLimitForCamera = lineLimitForCamera
    }

    var body: some View {
        buildLabels()
    }

    private func buildLabels() -> some View {
        VStack(
            alignment: .leading,
            spacing: 6
        ) {
            buildLabelRow(of: .rover, with: model.rover)
            buildLabelRow(of: .camera, with: model.camera)
                .lineLimit(lineLimitForCamera)
            buildLabelRow(of: .date, with: model.date)
        }
    }

    private func buildLabelRow(
        of type: LabelRowType,
        with value: String
    ) -> some View {
        Group {
            Text(type.rawValue.capitalized)
                .foregroundColor(.layerTwo) +
            Text(": ") +
            Text(value)
                .foregroundColor(.layerOne)
                .font(.system(size: 16, weight: .bold))
        }
    }
}
