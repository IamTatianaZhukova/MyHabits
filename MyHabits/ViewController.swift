//
//  ViewController.swift
//  MyHabits
//
//  Created by Татьяна Жукова on 20.04.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupUI()
        setupeConstraite()
    }

    private let logoLabel: UILabel = {
        let logoText = UILabel()
        logoText.translatesAutoresizingMaskIntoConstraints = false
        logoText.text = "MyHabit"
        logoText.textColor = .purple
        logoText.font = UIFont.systemFont(ofSize: 20, weight: .bold)

        return logoText
    }()

    private let logoImage: UIImageView = {
        let logotip = UIImageView()
        logotip.translatesAutoresizingMaskIntoConstraints = false
        logotip.image = UIImage(named: "AppIcon-1024px")
        logotip.layer.borderWidth = 2
        logotip.layer.borderColor = UIColor.white.cgColor
        logotip.layer.cornerRadius = 20

        return logotip
    }()

    private func setupUI() {
        view.addSubview(logoLabel)
        view.addSubview(logoImage)
    }

    private func setupeConstraite() {
        NSLayoutConstraint.activate([
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: 150),
            logoImage.heightAnchor.constraint(equalToConstant: 150),

            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        ])
    }
}

