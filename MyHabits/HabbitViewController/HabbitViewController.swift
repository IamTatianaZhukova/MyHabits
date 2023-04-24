//
//  HabbitViewController.swift
//  MyHabits
//
//  Created by Татьяна Жукова on 20.04.2023.
//

import UIKit

class HabbitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupUI()
        setupConstraints()
    }

    private let addPlusButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.tintColor = .purple
        //$0.addTarget(self, action: #selector(crossButtonAction), for: .touchUpInside)

        return $0
    }(UIButton())

    private func setupUI() {
        view.addSubview(addPlusButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            addPlusButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            addPlusButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addPlusButton.widthAnchor.constraint(equalToConstant: 20),
            addPlusButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
