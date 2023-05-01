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
        $0.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: "progressID")
        $0.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: "habitID")
        $0.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "defaultID")

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

        setupUI()
        setupConstraints()
        navigationBar()
        collectionView.reloadData()

        tabBarController?.tabBar.isHidden = false
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }

    private func progressView() {
        let progressCell = ProgressCollectionViewCell()
        progressCell.progressView.progress = HabitsStore.shared.todayProgress
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

extension HabitsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 { return 1 }
        if section == 1 { return HabitsStore.shared.habits.count }

        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "progressID", for: indexPath) as? ProgressCollectionViewCell else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "defaultID", for: indexPath)

                return cell
            }
            cell.layer.cornerRadius = 8
            cell.clipsToBounds = true
            cell.backgroundColor = .white
            cell.progressView.progress = HabitsStore.shared.todayProgress

            return cell
        }

        if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "habitID", for: indexPath) as? HabitCollectionViewCell else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "defaultID", for: indexPath)

                return cell
            }
            cell.layer.cornerRadius = 8
            cell.clipsToBounds = true
            cell.backgroundColor = .white
            cell.setup(index: indexPath.row)

            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "defaultId", for: indexPath)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let insets = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        let interItemSpacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
        let wight = collectionView.frame.width - (Columns.numberOfItemsInLine - 1) * interItemSpacing - insets.left - insets.right
        let itemWight = floor(wight / Columns.numberOfItemsInLine)
        wightHeader = itemWight

        if indexPath.section == 0 {
            return CGSize(width: itemWight, height: 60)
        }

        return CGSize(width: itemWight, height: 120)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let habitDetailsVC = HabitDetailsViewController()
            habitDetailsVC.numberHabitDetailsVC = indexPath.row
            habitDetailsVC.navigationItem.title = HabitsStore.shared.habits[indexPath.row].name
            navigationController?.pushViewController(habitDetailsVC, animated: true)
        }
    }
}
