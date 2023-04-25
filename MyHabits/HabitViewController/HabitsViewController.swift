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
        addButtonTabBarFunc()
        navigationBarFunc()
    }

    private lazy var addHabitButton: UIBarButtonItem = {
        $0.image = UIImage(systemName: "plus")
        $0.tintColor = UIColor(named: "ColorPurple")
        $0.target = self
        $0.style = .plain
        $0.action = #selector(addHabitAction)

        return $0
    }(UIBarButtonItem())

    @objc func addHabitAction(_ : UIButton) {
        let addHabit = HabitViewController()
        let navСontroller = UINavigationController(rootViewController: addHabit)
        navСontroller.modalPresentationStyle = .fullScreen
        self.navigationController?.present(navСontroller, animated: true, completion: nil)
    }

    private func setupUI() {

    }

    private func setupConstraints() {

    }

    private func addButtonTabBarFunc() {
        navigationItem.rightBarButtonItems = [addHabitButton]
        navigationItem.rightBarButtonItem = addHabitButton
    }

    private func navigationBarFunc() {
        self.navigationItem.title = "Сегодня"
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    @objc func addHabit() {
        let addHabit = HabitViewController()
        let navСontroller = UINavigationController(rootViewController: addHabit)
        navСontroller.modalPresentationStyle = .fullScreen
        self.navigationController?.present(navСontroller, animated: true, completion: nil)
    }
}
