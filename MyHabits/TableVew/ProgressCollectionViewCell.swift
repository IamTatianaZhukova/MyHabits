//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Татьяна Жукова on 25.04.2023.
//

import UIKit

final class ProgressCollectionViewCell: UICollectionViewCell {


    private lazy var nameProgressLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Всё получится!"
        $0.textColor = .systemGray
        $0.font = UIFont.systemFont(ofSize: 13, weight: .semibold)

        return $0
    }(UILabel())


    private lazy var percentLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .systemGray
        $0.font = UIFont.systemFont(ofSize: 13, weight: .semibold)

        return $0
    }(UILabel())



    private lazy var progressView: UIProgressView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setProgress(0, animated: false)
        $0.progressViewStyle = .default
        $0.progressTintColor = UIColor(red: 0.631, green: 0.086, blue: 0.8, alpha: 1)
        $0.layer.cornerRadius = 3.5
        $0.layer.masksToBounds = true

        return $0
    }(UIProgressView())


    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.cornerRadius = 8
        backgroundColor = .white

        setupUI()
        setupConstraints()
    }

    func setupProgressCell() {
        let todayProgress = HabitsStore.shared.todayProgress;
        progressView.setProgress(todayProgress, animated: false)
        percentLabel.text = "\(Int(todayProgress * 100))%"
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
            nameProgressLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameProgressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),

            percentLabel.topAnchor.constraint(equalTo: nameProgressLabel.topAnchor),
            percentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            progressView.topAnchor.constraint(equalTo: nameProgressLabel.bottomAnchor, constant: 10),
            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressView.heightAnchor.constraint(equalToConstant: 7),
        ])
    }
}
