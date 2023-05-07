//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Татьяна Жукова on 20.04.2023.
//

import UIKit

class HabitsViewController: UIViewController {

    private enum Columns {
        static let numberOfItemsInLine: CGFloat = 1
    }

    private lazy var addHabitButton: UIBarButtonItem = {
        $0.image = UIImage(systemName: "plus")
        $0.tintColor = UIColor(named: "ColorPurple")
        $0.target = self
        $0.style = .plain
        $0.action = #selector(addHabit)

        return $0
    }(UIBarButtonItem())

    @objc func addHabit() {
        let addHabit = HabitViewController()
        let navСontroller = UINavigationController(rootViewController: addHabit)
        navСontroller.modalPresentationStyle = .fullScreen
        self.navigationController?.present(navСontroller, animated: true, completion: nil)
    }

    private func addButtonTabBar() {
        navigationItem.rightBarButtonItems = [addHabitButton]
        navigationItem.rightBarButtonItem = addHabitButton
    }

    private func navigationBar() {
        self.navigationItem.title = "Сегодня"
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    private lazy var layout: UICollectionViewFlowLayout = {
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = 12
        $0.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

        return $0
    }(UICollectionViewFlowLayout())

    private lazy var collectionView: UICollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(named: "Gray")
        $0.delegate = self
        $0.dataSource = self
        $0.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ProgressCollectionViewCell.self))
        $0.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HabitCollectionViewCell.self))

        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: self.layout))

    private var wightHeader: CGFloat = 0
    var time = "0"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupUI()
        setupConstraints()
        addButtonTabBar()
        navigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        collectionView.reloadData()

        self.navigationController?.navigationBar.prefersLargeTitles  = false
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }

    private func setupUI() {
        view.addSubview(collectionView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HabitsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if section == 0 {
            return 1
        } else {
            return HabitsStore.shared.habits.count
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProgressCollectionViewCell.self), for: indexPath) as! ProgressCollectionViewCell
            cell.setupProgressCell()


            return cell

        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitCollectionViewCell.self), for: indexPath) as! HabitCollectionViewCell
            cell.setupCell(habit: HabitsStore.shared.habits[indexPath.item], index: indexPath.item)
            cell.delegate = self
            return cell
        }

    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {

    private var sideInset: CGFloat { return 16 }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.bounds.width - sideInset * 2

        if indexPath.section == 0 {
            return CGSize(width: width, height: 60)

        } else {
            return CGSize(width: width, height: 130)
        }
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        if section == 0 {
            return  UIEdgeInsets(top: 22, left: 0, bottom: 6, right: 0)
        } else {
            return UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if indexPath.section != 0 {
            let habitDetailsVC = HabitDetailsViewController()
            habitDetailsVC.numberHabitDetailsVC = indexPath.row
            habitDetailsVC.navigationItem.title = HabitsStore.shared.habits[indexPath.row].name
            self.navigationController?.pushViewController(habitDetailsVC, animated: true)
        }
    }
}


extension HabitsViewController :  HabitCollectionViewCellDelegate {

    func didTapRoundImage() {
        collectionView.reloadData()
    }

}
