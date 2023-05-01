//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Татьяна Жукова on 25.04.2023.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {

    private lazy var nameProgressLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Всё получится!"
        $0.numberOfLines = 0
        $0.textColor = .systemGray
        $0.font = UIFont.systemFont(ofSize: 13, weight: .semibold)

        return $0
    }(UILabel())

    private lazy var percentLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        var percent: Int = Int(HabitsStore.shared.todayProgress * 100)
        $0.text = "\(percent) %"
        $0.textColor = .systemGray
        $0.font = UIFont.systemFont(ofSize: 13, weight: .semibold)

        return $0
    }(UILabel())

    lazy var progressView: UIProgressView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.progressTintColor = UIColor(named: "ColorPurple")
        $0.progress = HabitsStore.shared.todayProgress

        return $0
    }(UIProgressView())

    override init(frame: CGRect) {
        super .init(frame: frame)

        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(nameProgressLabel)
        contentView.addSubview(percentLabel)
        contentView.addSubview(progressView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameProgressLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            nameProgressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            percentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            percentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            progressView.topAnchor.constraint(equalTo: nameProgressLabel.bottomAnchor, constant: 12),
            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            progressView.trailingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -16)
        ])
    }
}
