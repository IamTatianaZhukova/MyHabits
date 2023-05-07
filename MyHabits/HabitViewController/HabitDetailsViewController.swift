//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Татьяна Жукова on 25.04.2023.
//

import UIKit

class HabitDetailsViewController: UIViewController {

    var habit: Habit?

    private lazy var tableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.dataSource = self
        $0.delegate = self
        $0.register(HabitTableViewCell.self, forCellReuseIdentifier: "customCell")
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "defaultCell")
        $0.register(HabitTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "headerId")

        return $0
    }(UITableView(frame: .zero, style: .grouped))

    private lazy var changeHabitBarButton: UIBarButtonItem = {
        $0.target = self
        $0.style = .plain
        $0.title = "Править"
        $0.action = #selector(changeHabit)
        $0.tintColor = UIColor(named: "ColorPurple")
        
        return $0
    }(UIBarButtonItem())

    @objc func changeHabit(sender: UIButton) {
        let habitVC = HabitViewController()

        habitVC.habitState = .edit

        habitVC.numberHabitVC = numberHabitDetailsVC

        habitVC.closure = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }

        habitVC.nameHabitTextField.text = HabitsStore.shared.habits[numberHabitDetailsVC].name
        habitVC.setText = HabitsStore.shared.habits[numberHabitDetailsVC].name

        habitVC.colorChangeButton.backgroundColor = HabitsStore.shared.habits[numberHabitDetailsVC].color
        habitVC.setColor = HabitsStore.shared.habits[numberHabitDetailsVC].color

        habitVC.timeLabel.text = HabitsStore.shared.habits[numberHabitDetailsVC].dateString
        habitVC.setTime = HabitsStore.shared.habits[numberHabitDetailsVC].date
        habitVC.timePicker.date = HabitsStore.shared.habits[numberHabitDetailsVC].date

        let navigationVC = UINavigationController(rootViewController: habitVC)
        navigationVC.modalPresentationStyle = .fullScreen
        self.navigationController?.present(navigationVC, animated: true)
    }

    var numberHabitDetailsVC = 0
    var arriveDates: [Int] = []
    var indexDate = 100

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
        navigationController()
        indexTable()
    }

    private func setupUI() {
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func navigationController() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = UIColor(named: "ColorPurple")
        navigationItem.largeTitleDisplayMode = .never

        navigationItem.rightBarButtonItems = [changeHabitBarButton]
        navigationItem.rightBarButtonItem = changeHabitBarButton
    }

    private func indexTable() {
        for (i, v) in HabitsStore.shared.dates.enumerated() {
            if HabitsStore.shared.habits[numberHabitDetailsVC].date.formatted(date: .long, time: .omitted) == v.formatted(date: .long, time: .omitted) {
                indexDate = i
            }
            if i >= indexDate {
                arriveDates.append(i)
            }
        }
    }
}

extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arriveDates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? HabitTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)

            return cell
        }

        let index = arriveDates[indexPath.row]

        cell.dateLabel.text = HabitsStore.shared.trackDateString(forIndex: index)

        if HabitsStore.shared.habit(HabitsStore.shared.habits[numberHabitDetailsVC], isTrackedIn: HabitsStore.shared.dates[index]) {
            cell.checkMarkImageView.isHidden = false
        }

        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerId") as? HabitTableViewHeader else { return nil }

            return headerView
        }
        return nil
    }
}
