import SwiftUI

public struct DashboardView: View {
    @StateObject private var viewModel: DashboardViewModel

    public init(viewModel: DashboardViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }

    public var body: some View {
        VStack {
            if viewModel.loading {
                PreloaderView()
            } else {
                Text("loaded")
                    .foregroundColor(.white)
            }
        }.task {
            await viewModel.fetchPhotos()
        }
    }
}

