//
//  TabBarController.swift
//  MyHabits
//
//  Created by Татьяна Жукова on 20.04.2023.
//

import UIKit

final class TabBarController: UITabBarController {

    // MARK: - Properties

    var habitsViewController: UINavigationController!
    var infoViewController: UINavigationController!

    // MARK: - Life cycle

    override func viewDidLoad() {
         super.viewDidLoad()

        setupUI()
    }

    // MARK: - Methods

    private func setupUI() {
        habitsViewController = UINavigationController.init(rootViewController: HabitsViewController())
        infoViewController = UINavigationController.init(rootViewController: InfoViewController())

        self.viewControllers = [habitsViewController, infoViewController]

        let item1 = UITabBarItem(title: "Привычки", image: UIImage (systemName: "rectangle.grid.1x2.fill"), tag: 0)

        let item2 = UITabBarItem(title: "Информация", image: UIImage(systemName: "info.circle.fill"), tag: 1)

        habitsViewController.tabBarItem = item1
        infoViewController.tabBarItem = item2

        UITabBar.appearance().tintColor = UIColor(named: "ColorPurple")
        UITabBar.appearance().backgroundColor = .systemGray2
    }
}
