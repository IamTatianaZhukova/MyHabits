//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Татьяна Жукова on 25.04.2023.
//

import UIKit

final class HabitCollectionViewCell: UICollectionViewCell {

    weak var delegate: HabitCollectionViewCellDelegate?

    private lazy var nameHabit: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        $0.numberOfLines = 2

        return $0
    }(UILabel())

    private lazy var timeHabit: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .systemGray2
        $0.font = .systemFont(ofSize: 12)

        return $0
    }(UILabel())

    private lazy var counter: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .systemGray2
        $0.font = .systemFont(ofSize: 13)

        return $0
    }(UILabel())

    lazy var checkMarkButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 2.5
        $0.addTarget(self, action: #selector(executionHabit), for: .touchUpInside)
        $0.setImage(UIImage(systemName: "checkmark"), for: .normal)
        $0.tintColor = .white

        return $0
    }(UIButton())

    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.cornerRadius = 8
        clipsToBounds = true
        backgroundColor = .white

        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        nameHabit.text = nil
        nameHabit.textColor = nil
        timeHabit.textColor = nil
        checkMarkButton.layer.borderColor = nil
        checkMarkButton.layer.backgroundColor = nil
        counter.text = nil
    }

    private func setupUI() {
        contentView.addSubview(nameHabit)
        contentView.addSubview(timeHabit)
        contentView.addSubview(counter)
        contentView.addSubview(checkMarkButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            checkMarkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkMarkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            checkMarkButton.heightAnchor.constraint(equalToConstant: 40),
            checkMarkButton.widthAnchor.constraint(equalToConstant: 40),

            nameHabit.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameHabit.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameHabit.trailingAnchor.constraint(equalTo: checkMarkButton.leadingAnchor, constant: -40),

            timeHabit.topAnchor.constraint(equalTo: nameHabit.bottomAnchor, constant: 5),
            timeHabit.leadingAnchor.constraint(equalTo: nameHabit.leadingAnchor),

            counter.leadingAnchor.constraint(equalTo: nameHabit.leadingAnchor),
            counter.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }

    func setupCell(habit: Habit, index: Int) {
        nameHabit.tag = index
        nameHabit.text = habit.name
        nameHabit.textColor = habit.color
        timeHabit.text = "Каждый день в \(habit.dateString)"
        counter.text = "Счетчик: \(habit.trackDates.count)"
        checkMarkButton.layer.borderColor = habit.color.cgColor

        if habit.isAlreadyTakenToday {
            checkMarkButton.backgroundColor = UIColor(cgColor: checkMarkButton.layer.borderColor ?? UIColor.white.cgColor)
        } else {
            checkMarkButton.backgroundColor = .white
        }
    }

    @objc func executionHabit(_ sender: UIButton) {
        let index = nameHabit.tag

        if HabitsStore.shared.habits[index].isAlreadyTakenToday {
            print("executionHabit")
        } else {
            checkMarkButton.backgroundColor = UIColor(cgColor: checkMarkButton.layer.borderColor ?? UIColor.white.cgColor)
            HabitsStore.shared.track(HabitsStore.shared.habits[index])
            counter.text = "Счетчик: \(HabitsStore.shared.habits[index].trackDates.count)"
            self.delegate?.didTapRoundImage()
        }
    }
}

protocol HabitCollectionViewCellDelegate: AnyObject {
    func didTapRoundImage()
}
