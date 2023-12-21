import SwiftUI
import Commons

public extension View {

    func componentPresenter<PopupContent: View, Config: ComponentPresentable>(
        config: Binding<Config?>,
        allowToCloseOnTapBackground: Bool = false,
        onDismiss: (() -> ())? = nil,
        view: @escaping () -> PopupContent
    ) -> some View {
            self.modifier(
                ComponentPresenter(
                    config: config,
                    view: view,
                    allowToCloseOnTapBackground: allowToCloseOnTapBackground,
                    onDismiss: onDismiss
                )
            )
        }
}
