import SwiftUI
import UICommons
import Design
import NasaAPIService

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

                VStack {
                    Text(viewModel.selectedCamera.rawValue)
                        .onTapGesture {
                            viewModel.showBottomSheetPicker(of: .camera)
                        }
                        .foregroundColor(.white)

                    Text(viewModel.selectedRover.rawValue)
                        .onTapGesture {
                            viewModel.showBottomSheetPicker(of: .rover)
                        }
                        .foregroundColor(.white)

                    Button {
                        Task {
                            await viewModel.fetchPhotos()
                        }
                    } label: {
                        Text("Load photos")
                    }
                }

            }
        }
        .bottomSheet(
            isShowing: $viewModel.showRoverPicker,
            using: viewModel.roverPickerViewModel()
        )
        .bottomSheet(
            isShowing: $viewModel.showCameraPicker,
            using: viewModel.cameraPickerViewModel()
        )
    }
}
