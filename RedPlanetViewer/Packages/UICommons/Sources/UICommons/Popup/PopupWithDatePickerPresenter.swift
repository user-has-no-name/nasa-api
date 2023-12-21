import Commons
import SwiftUI

public extension View {

    func popupPresenter(
        config: Binding<PopupWithDatePickerModel?>,
        forFullScreen: Bool = true,
        onAppearAction: (() -> Void)? = nil,
        onDissappearAction: (() -> Void)? = nil
    ) -> some View {
        func buildForFullscreen(_ content: some View) -> some View {
            ZStack {
                Color.layerOne
                    .blur(radius: 5.0, opaque: true)
                    .ignoresSafeArea(.all)
                    .opacity(0.5)
                content
            }
        }

        func buildPopupView() -> some View {
            PopupWithDatePickerView(config.wrappedValue)
                .frame(maxWidth: 350.0)
                .padding(.horizontal, 20.0)
                .onAppear {
                    onAppearAction?()
                }
                .onDisappear {
                    onDissappearAction?()
                }
        }

        return self.componentPresenter(config: config) {
            if forFullScreen {
                return buildForFullscreen(buildPopupView()).toAnyView()
            } else {
                return buildPopupView().toAnyView()
            }
        }
    }
}
