//
//  SplashScreen.swift
//  MyHabits
//
//  Created by Татьяна Жукова on 21.04.2023.
//

import UIKit

class SplashScreen: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        setupeUI()
        setupeConstraits()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

    private func setupeUI() {
        addSubview(logoLabel)
        addSubview(logoImage)
    }

    private func setupeConstraits() {
        NSLayoutConstraint.activate([
            logoImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: 150),
            logoImage.heightAnchor.constraint(equalToConstant: 150),

            logoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -100)
        ])
    }
}
