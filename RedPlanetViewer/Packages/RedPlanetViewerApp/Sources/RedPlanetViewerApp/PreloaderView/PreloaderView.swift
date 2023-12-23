import Animation
import Design
import SwiftUI

struct PreloaderView: View {
    @ObservedObject private var viewModel: PreloaderViewModel

    init(viewModel: PreloaderViewModel) {
        self._viewModel = .init(initialValue: viewModel)
    }

    var body: some View {
        buildContent()
            .task {
                await viewModel.prefetchData()
            }
    }

    private func buildContent() -> some View {
        ZStack {
            Color.backgroundOne.ignoresSafeArea()
            buildLogo()
        }
        .overlay(alignment: .bottom) {
            LottieView(
                animationConfiguration: .loader,
                contentMode: .scaleAspectFill
            )
            .frame(
                maxWidth: 200.0,
                maxHeight: 50.0
            )
            .padding(.bottom, 24.0)
        }
    }

    private func buildLogo() -> some View {
        Image(named: .appIcon)
            .resizable()
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 30.0)
                    .fill(Color.accentOne)
            )
            .frame(width: 123.0, height: 123.0)
            .shadow(color: .layerOne.opacity(0.1), radius: 27.5, x: 0, y: 20)
    }
}
