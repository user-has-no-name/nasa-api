import SwiftUI
import Commons

public extension View {

    func loaderPresenter(
        config: Binding<LoaderConfiguration?>,
        forFullScreen: Bool = true,
        onDissappearAction: (() -> Void)? = nil
    ) -> some View {
        func buildForFullscreen(_ content: some View) -> some View {
            ZStack {
                Color.black
                    .blur(radius: 5, opaque: true)
                    .ignoresSafeArea(.all)
                    .opacity(0.8)
                content
            }
        }

        func buildLoaderView() -> some View {
            LoaderView()
        }

        return self.componentPresenter(config: config, onDismiss: onDissappearAction) {
            forFullScreen ?
                buildForFullscreen(buildLoaderView()).toAnyView() :
                    buildLoaderView().toAnyView()
        }
    }
}
