import Design
import Commons
import UICommons
import SwiftUI

struct HistoryView: View {
    @EnvironmentObject private var viewModel: HistoryViewModel

    var body: some View {
        buildContent()
            .onAppear {
                viewModel.fetchSavedFilters()
            }
            .confirmationDialog(
                "Menu Filter",
                isPresented: $viewModel.showConfirmation,
                titleVisibility: .visible
            ) {
                Group {
                    Button("Use") {
                        viewModel.pickFilter()
                        viewModel.goBackToDashboard()
                    }

                    Button("Delete", role: .destructive) {
                        withAnimation {
                            viewModel.removeFilter()
                        }
                    }
                }

                Button("Cancel", role: .cancel) {
                    viewModel.showConfirmation = false
                }
            }
    }

    private func buildContent() -> some View {
        VStack {
            buildHeader()
            if viewModel.savedFilters.isEmpty {
                Spacer()
                EmptyStateView(for: .history)
            } else {
                setupList()
            }

            Spacer()
        }
        .background(Color.backgroundOne)
    }

    private func buildHeader() -> some View {
        ZStack {
            Color.accentOne.ignoresSafeArea()
                .shadow(color: .layerOne.opacity(0.12), radius: 6, x: 0, y: 5)

            HStack {
                Button {
                    viewModel.goBackToDashboard()
                } label: {
                    Image(named: .leftIcon)
                }
                Spacer()
                Text("History")
                    .font(.system(size: 34, weight: .bold))
                Spacer()
                Rectangle()
                    .fill(.clear)
                    .frame(width: 32.0, height: 32.0)
            }
            .padding(20.0)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: 78.0
        )
    }

    private func setupList() -> some View {
        ScrollView {
            ForEach(viewModel.savedFilters, id: \.id) { filter in
                LazyVStack {
                    FiltersCardView(
                        model: .init(
                            rover: filter.rover.rawValue,
                            camera: filter.camera.rawValue,
                            date: filter.date.toString(format: .dashboardHeader)
                        )
                    )
                    .padding(.horizontal, 20.0)
                }

                .onTapGesture {
                    viewModel.selectedFilter = filter
                    viewModel.showConfirmation = true
                }
            }
            .padding(.top, 20.0)
            .padding(.bottom, 24.0)
        }
    }
}
