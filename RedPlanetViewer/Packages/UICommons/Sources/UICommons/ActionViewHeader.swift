import SwiftUI

public struct ActionViewHeader: View {
    private let title: String
    private let onCloseTapAction: () -> Void
    private let onAcceptTapAction: () -> Void

    public init(
        title: String,
        onCloseTapAction: @escaping () -> Void,
        onAcceptTapAction: @escaping () -> Void
    ) {
        self.title = title
        self.onCloseTapAction = onCloseTapAction
        self.onAcceptTapAction = onAcceptTapAction
    }

    public var body: some View {
        HStack {
            Button {
                onCloseTapAction()
            } label: {
                Image(named: .closeIcon)
            }
            Spacer()
            Text(title)
                .font(.system(size: 22, weight: .bold))
            Spacer()
            Button {
                onAcceptTapAction()
            } label: {
                Image(named: .tickIcon)
            }
        }
    }
}
