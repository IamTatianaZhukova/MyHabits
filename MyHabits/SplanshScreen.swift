//
//  SplanshScreen.swift
//  MyHabits
//
//  Created by Татьяна Жукова on 20.04.2023.
//

import UIKit

class SplanshScreen: UIView {

    let logoLabel: UILabel = {
        let logo = UILabel()
        logo.text = "MyHabits"
        logo.textColor = .purple
        logo.font = .systemFont(ofSize: 20)
        logo.translatesAutoresizingMaskIntoConstraints = false

        return logo
    }()

    let logoImage: UIImageView = {
        let logotip = UIImageView()
        logotip.image = UIImage(named: "AppIcon-1024px")
        logotip.layer.cornerRadius = 55
        logotip.translatesAutoresizingMaskIntoConstraints = false

        return logotip
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstrait()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI () {
        addSubview(logoImage)
        addSubview(logoLabel)
    }

    private func setupConstrait() {
        NSLayoutConstraint.activate([
            logoImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: 75),
            logoImage.heightAnchor.constraint(equalToConstant: 75),

            logoLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 100)
        ])
    }
}
