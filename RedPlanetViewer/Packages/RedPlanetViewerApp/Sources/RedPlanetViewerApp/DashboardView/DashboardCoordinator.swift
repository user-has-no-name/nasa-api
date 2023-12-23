import Navigation
import UIKit
import Database

public struct DashboardDependency: Dependency {
    public let selectedFilter: Filter
    public let marsPhotos: MarsPhotos

    public init(
        selectedFilter: Filter,
        marsPhotos: MarsPhotos
    ) {
        self.selectedFilter = selectedFilter
        self.marsPhotos = marsPhotos
    }
}

public final class DashboardCoordinator: Coordinator {
    public weak var parentCoordinator: (any Coordinator)?
    public var children: Array<any Coordinator> = .init()

    public var navigationController: UINavigationController
    public var dependency: DashboardDependency?

    public init(
        navigationController: UINavigationController,
        dependency: DashboardDependency
    ) {
        self.navigationController = navigationController
        self.dependency = dependency
    }

    public func start() {
        navigateToDashboard(
            filter: dependency?.selectedFilter ?? .default(),
            photos: dependency?.marsPhotos ?? .init(photos: .init())
        )
    }

    private func navigateToDashboard(
        filter: Filter,
        photos: MarsPhotos
    ) {
        let dashboardView: DashboardView = .init(viewModel: .init(
            selectedFilter: filter,
            photos: photos,
            navigation: self
        ))
        let hostingController: HostingController = .init(for: dashboardView)
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(hostingController, animated: true)
        navigationController.makeRootWith(hostingController)
    }
}

extension DashboardCoordinator: DashboardNavigation {

    public func goToHistoryPage(_ listener: HistoryListener) {
        let historyView = HistoryView()
            .environmentObject(
                HistoryViewModel(navigation: self, listener: listener)
            )
        let hostingController: HostingController = .init(for: historyView)
        navigationController.pushViewController(hostingController, animated: true)
    }
}

extension DashboardCoordinator: HistoryViewNavigation {

    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
