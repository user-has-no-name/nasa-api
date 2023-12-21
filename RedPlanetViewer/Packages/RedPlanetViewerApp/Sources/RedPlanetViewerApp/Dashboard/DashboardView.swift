import SwiftUI
import UICommons
import Commons
import Design
import NasaAPIService

public struct DashboardView: View {
    @StateObject private var viewModel: DashboardViewModel

    public init(viewModel: DashboardViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }

    public var body: some View {
        ZStack {
            Color.backgroundOne.ignoresSafeArea()

            if viewModel.loading {
                PreloaderView()
            } else {
                VStack {
                    setupHeader()
                    setupList()
                    Spacer()
                }
                .ignoresSafeArea(edges: .bottom)
            }
        }
        .overlay(alignment: .bottomTrailing) {
            HistoryButton {

            }
            .padding(.trailing, 20.0)
        }
        .task {
            await viewModel.fetchPhotos()
        }
        .onChange(of: viewModel.selectedValues) { _ in
            Task {
                viewModel.clearResults()
                await viewModel.fetchPhotos()
            }
        }
        .toastView(config: $viewModel.toastConfig)
        .popupPresenter(config: $viewModel.popupConfig)
        .bottomSheet(
            isShowing: $viewModel.showRoverPicker,
            using: viewModel.roverPickerViewModel()
        )
        .bottomSheet(
            isShowing: $viewModel.showCameraPicker,
            using: viewModel.cameraPickerViewModel()
        )
    }

    private func setupHeader() -> some View {
        ZStack {
            Color.accentOne.ignoresSafeArea()
                .shadow(color: .black.opacity(0.12), radius: 6, x: 0, y: 5)

            VStack(spacing: 22.0) {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("MARS.CAMERA")
                            .font(.system(size: 34, weight: .bold))

                        Text(viewModel.selectedDate.toString(format: .dashboardHeader))
                            .font(.system(size: 17, weight: .bold))
                    }
                    Spacer()

                    Button {
                        viewModel.showPopup()
                    } label: {
                        Image(named: .calendarIcon)
                    }
                    .frame(width: 44.0, height: 44.0)
                }

                HStack(spacing: 23.0) {
                    HStack(spacing: 12.0) {
                        FilterButton(type: .rover, selectedValue: viewModel.selectedRover.fullName) {
                            viewModel.showBottomSheetPicker(of: .rover)
                        }

                        FilterButton(type: .camera, selectedValue: viewModel.selectedCamera.fullName) {
                            viewModel.showBottomSheetPicker(of: .camera)
                        }
                    }

                    Button {

                    } label: {
                        Image(named: .addIcon)
                            .frame(width: 38.0, height: 38.0)
                            .background(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .fill(Color.backgroundOne)
                                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 4)
                            )
                    }
                }
            }
            .padding(20.0)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: 148.0
        )
    }

    private func setupList() -> some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 12.0) {
                ForEach(viewModel.photos.photos, id: \.id) { photo in
                    CardView(
                        imageURL: .init(string: photo.imgSrc),
                        model: .init(
                            rover: photo.rover.name,
                            camera: photo.camera.fullName,
                            date: (photo.earthDate.toDate(format: .api) ?? Date()).toString(format: .dashboardHeader)
                        )
                    )
                    .padding(.horizontal, 20.0)    
                    .task {
                        await viewModel.loadMoreIfNeeded(lastAppearedCard: photo)
                    }
                }
            }
            .padding(.top, 20.0)
            .padding(.bottom, 24.0)
        }
    }
}
