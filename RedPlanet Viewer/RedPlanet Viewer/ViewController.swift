//
//  ViewController.swift
//  RedPlanet Viewer
//
//  Created by Oleksandr Zavazhenko on 18/12/2023.
//

import UIKit

final class ViewController: UIViewController {

    private let label: UILabel = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        label.text = "Hello world"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
