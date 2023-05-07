//
//  HabitTableViewCell.swift
//  MyHabits
//
//  Created by Татьяна Жукова on 25.04.2023.
//

import UIKit

final class HabitTableViewCell: UITableViewCell {

    lazy var dateLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 17)

        return $0
    }(UILabel())

    lazy var checkMarkImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "checkmark")
        $0.tintColor = UIColor(named: "ColorPurple")
        $0.isHidden = true

        return $0
    }(UIImageView())

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(checkMarkImageView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),

            checkMarkImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            checkMarkImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            checkMarkImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            checkMarkImageView.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
}
