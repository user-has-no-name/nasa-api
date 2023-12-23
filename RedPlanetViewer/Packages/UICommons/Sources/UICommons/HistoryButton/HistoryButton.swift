import Design
import SwiftUI

public struct HistoryButton: View {
    private let onTapAction: () -> Void

    public init(
        onTapAction: @escaping () -> Void
    ) {
        self.onTapAction = onTapAction
    }

    public var body: some View {
        buildContent()
    }

    public func buildContent() -> some View {
        Button {
            onTapAction()
        } label: {
            ZStack {
                Circle()
                    .fill(Color.accentOne)
                    .shadow(
                        color: .layerOne.opacity(0.2),
                        radius: 5,
                        x: 0, y: 2
                    )

                Image(named: .historyIcon)
                    .frame(
                        width: 44.0,
                        height: 44.0
                    )
            }
            .frame(
                width: 70.0,
                height: 70.0
            )
        }
    }
}


#Preview {
    HistoryButton(onTapAction: { })
}
