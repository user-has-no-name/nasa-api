import SwiftUI

public enum FilterButtonType {
    case rover, camera
}

public struct FilterButton: View {
    private let type: FilterButtonType
    private let selectedValue: String
    private let onTapAction: () -> Void

    public init(
        type: FilterButtonType,
        selectedValue: String,
        onTapAction: @escaping () -> Void
    ) {
        self.type = type
        self.selectedValue = selectedValue
        self.onTapAction = onTapAction
    }

    public var body: some View {
        buildContent()
    }

    private func buildContent() -> some View {
        Button {
            onTapAction()
        } label: {
            HStack(
                alignment: .center,
                spacing: 6.0
            ) {
                Image(named: type == .camera ? .cameraIcon : .roverIcon)
                    .resizable()
                    .frame(width: 24.0, height: 24.0)

                Text(selectedValue)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.layerOne)

                Spacer()
            }
            .padding(7.0)
            .background(
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(Color.backgroundOne)
                    .shadow(
                        color: .layerOne.opacity(0.1),
                        radius: 5,
                        x: 0, y: 4
                    )
            )

        }
        .frame(maxWidth: .infinity)
    }
}
