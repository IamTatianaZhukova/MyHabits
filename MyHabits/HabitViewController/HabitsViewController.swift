//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Татьяна Жукова on 20.04.2023.
//

import UIKit

class HabitsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupUI()
        setupConstraints()
    }

    private let addHabitButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.tintColor = UIColor(named: "ColorPurple")
        $0.bounds = CGRect(x: 0, y: 0, width: 22, height: 22)
        $0.isUserInteractionEnabled = true
        let tapPlusButton = UITapGestureRecognizer(target: HabitsViewController.self, action: #selector(addHabitAction))
        $0.addGestureRecognizer(tapPlusButton)

        return $0
    }(UIButton())

    @objc func addHabitAction(_ : UIButton) {
        let addHabit = HabitViewController()
        let navСontroller = UINavigationController(rootViewController: addHabit)
        navСontroller.modalPresentationStyle = .fullScreen
        self.navigationController?.present(navСontroller, animated: true, completion: nil)
    }

    private func setupUI() {
        view.addSubview(addHabitButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            addHabitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            addHabitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
}
