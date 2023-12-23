import SwiftUI

public final class HostingController<SwiftUIView: View>: UIViewController {

    private let hostedController: UIHostingController<SwiftUIView>

    public init(
        for view: SwiftUIView
    ) {
        self.hostedController = .init(rootView: view)
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        addChild(hostedController)
        view.addSubview(hostedController.view)
        setupConstraints()
    }

    private func setupConstraints() {
        hostedController.view.backgroundColor = .clear
        hostedController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostedController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostedController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostedController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostedController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
