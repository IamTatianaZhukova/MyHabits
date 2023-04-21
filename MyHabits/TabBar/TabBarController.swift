//
//  TabBarController.swift
//  MyHabits
//
//  Created by Татьяна Жукова on 20.04.2023.
//

import UIKit

class TabBarController: UITabBarController {

    // MARK: - Properties

    var habbitViewController: UINavigationController!
    var infoViewController: UINavigationController!

    // MARK: - Life cycle

    override func viewDidLoad() {
         super.viewDidLoad()
    }

    // MARK: - Methods

    private func setupUI() {
        habbitViewController = UINavigationController.init(rootViewController: HabbitViewController())
        infoViewController = UINavigationController.init(rootViewController: InfoViewController())

        self.viewControllers = [habbitViewController, infoViewController]

        let item1 = UITabBarItem(title: "Привычки", image: UIImage (systemName: "rectangle.grid.1x2.fill"), tag: 0)

        let item2 = UITabBarItem(title: "Информация", image: UIImage(systemName: "info.circle.fill"), tag: 1)

        habbitViewController.tabBarItem = item1
        infoViewController.tabBarItem = item2

    }
}
