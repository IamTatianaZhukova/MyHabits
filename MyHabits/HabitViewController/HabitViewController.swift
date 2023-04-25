//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Татьяна Жукова on 24.04.2023.
//

import UIKit

class HabitViewController: UIViewController {

    lazy var saveHabitButton: UIBarButtonItem = {
        $0.target = self
        $0.style = .plain
        $0.title = "Сохранить"
        $0.tintColor = UIColor(named: "ColorPurple")
        $0.action = #selector(saveHabit)

        return $0
    }(UIBarButtonItem())

    lazy var cancelHabitButton: UIBarButtonItem = {
        $0.target = self
        $0.style = .plain
        $0.title = "Отменить"
        $0.tintColor = UIColor(named: "ColorPurple")
        $0.action = #selector(cancelHabit)

        return $0
    }(UIBarButtonItem())

    private lazy var nameHabitLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "НАЗВАНИЕ"
        $0.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        $0.textColor = .black

        return $0
    }(UILabel())

    lazy var nameHabitTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        $0.font = .systemFont(ofSize: 17)
        $0.textColor = .black

        return $0
    }(UITextField())

    private lazy var colorNameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "ЦВЕТ"
        $0.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        $0.textColor = .black

        return $0
    }(UILabel())

    lazy var colorChangeButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 15
        $0.backgroundColor = UIColor(named: "Orange")
        $0.addTarget(self, action: #selector(chooseColor), for: .touchUpInside)

        return $0
    }(UIButton())

    private lazy var timeNameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "ВРЕМЯ"
        $0.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        $0.textColor = .black

        return $0
    }(UILabel())

    private lazy var timeStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 5

        return $0
    }(UIStackView())

    private lazy var returnLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Каждый день в"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 17)

        return $0
    }(UILabel())

    lazy var timeLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 17)
        $0.textColor = UIColor(named: "ColorPurple")
        $0.text = setReturnTime

        return $0
    }(UILabel())

    lazy var timePicker: UIDatePicker = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.preferredDatePickerStyle = .wheels
        $0.datePickerMode = .time
        $0.addTarget(self, action: #selector(chooseTime), for: .valueChanged)

        return $0
    }(UIDatePicker())

    var setText: String = ""
    var setColor: UIColor = .systemOrange
    var setTime = Date()
    private var setReturnTime = ""

    var numberHabitVC = 0

    lazy var deleteHabitButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Удалить привычку", for: .normal)
        $0.setTitleColor(UIColor.systemRed, for: .normal)
        $0.addTarget(self, action: #selector(addTargetShowAlertDeleteHabit), for: .touchUpInside)
        $0.isHidden = true

        return $0
    }(UIButton())

    var alertController = UIAlertController(title: "Удалить привычку", message: "что-то", preferredStyle: .alert)
    let alertControllerCheckEmptyText = UIAlertController(title: "Ошибка", message: "название должно быть заполнено", preferredStyle: .alert)
    var titleView = "Создать"

    override func viewDidLoad() {
        super.viewDidLoad()

        realTime()
        view.backgroundColor = .systemBackground
        navigationController()
        setupUI()
        setupConstraints()
        setupAlertControllerDeleteHabit()
        setupAlertControllerCheckEmptyText()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }

    private func navigationController() {
        navigationItem.title = titleView
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.largeTitleDisplayMode = .never

        navigationItem.rightBarButtonItems = [saveHabitButton]
        navigationItem.rightBarButtonItem = saveHabitButton

        navigationItem.leftBarButtonItems = [cancelHabitButton]
        navigationItem.leftBarButtonItem = cancelHabitButton
    }

    private func setupUI() {
        view.addSubview(nameHabitLabel)
        view.addSubview(nameHabitTextField)
        view.addSubview(colorNameLabel)
        view.addSubview(colorChangeButton)
        view.addSubview(timeNameLabel)
        view.addSubview(timeStackView)
        timeStackView.addArrangedSubview(returnLabel)
        timeStackView.addArrangedSubview(timeLabel)
        view.addSubview(timePicker)
        view.addSubview(deleteHabitButton)
    }

    private func setupConstraints() {
        let guide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            nameHabitLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: 24),
            nameHabitLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            nameHabitTextField.topAnchor.constraint(equalTo: nameHabitLabel.bottomAnchor, constant: 8),
            nameHabitTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameHabitTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            colorNameLabel.topAnchor.constraint(equalTo: nameHabitTextField.bottomAnchor, constant: 16),
            colorNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            colorChangeButton.topAnchor.constraint(equalTo: colorNameLabel.bottomAnchor, constant: 8),
            colorChangeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            colorChangeButton.widthAnchor.constraint(equalToConstant: 30),
            colorChangeButton.heightAnchor.constraint(equalToConstant: 30),

            timeNameLabel.topAnchor.constraint(equalTo: colorChangeButton.bottomAnchor, constant: 16),
            timeNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            timeStackView.topAnchor.constraint(equalTo: timeNameLabel.bottomAnchor, constant: 8),
            timeStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            timePicker.topAnchor.constraint(equalTo: timeNameLabel.bottomAnchor, constant: 16),
            timePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            deleteHabitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            deleteHabitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func realTime() {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "HH:MM AM/PM"
        df.timeStyle = .short
        setReturnTime = df.string(from: date)
    }

    func setupAlertControllerDeleteHabit() {
        alertController.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { _ in
            self.deleteHabit()
        }))
        alertController.addAction(UIAlertAction(title: "Отменить", style: .cancel))
    }

    func setupAlertControllerCheckEmptyText() {
        alertControllerCheckEmptyText.addAction(UIAlertAction(title: "Попробовать ещё раз", style: .cancel))
    }

    @objc func saveHabit(){
        if self.nameHabitTextField.text == "" {
            addTargetShowAlertEmptyTextField()
        } else {
            if self.nameHabitTextField.text != nil {
                setText = self.nameHabitTextField.text!
            }

            let newHabit = Habit(name: setText, date: setTime, color: setColor)
            let store = HabitsStore.shared
            store.habits.append(newHabit)

            self.dismiss(animated: true)
        }
    }

    @objc func cancelHabit() {
        self.dismiss(animated: true)
    }

    @objc func chooseColor() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        present(colorPicker, animated: true)
    }

    @objc func chooseTime() {
        let time = DateFormatter()
        time.dateFormat = "HH:MM AM/PM"
        time.timeStyle = .short
        self.timeLabel.text = time.string(from: self.timePicker.date)

        setTime = self.timePicker.date
    }

    @objc func editHabit() {
        if self.nameHabitTextField.text == "" {
            addTargetShowAlertEmptyTextField()
        } else {
            if self.nameHabitTextField.text != nil {
                setText = self.nameHabitTextField.text!
            }
            HabitsStore.shared.habits[numberHabitVC].name = setText
            HabitsStore.shared.habits[numberHabitVC].date = setTime
            HabitsStore.shared.habits[numberHabitVC].color = setColor

            self.navigationController?.popToRootViewController(animated: true)
        }
    }

    @objc func cancelEdit() {
        self.navigationController?.popToRootViewController(animated: true)
    }

    @objc func deleteHabit() {
        HabitsStore.shared.habits.remove(at: numberHabitVC)
        self.navigationController?.popToRootViewController(animated: true)
    }

    @objc func addTargetShowAlertDeleteHabit () {
        self.present(alertController, animated: true, completion: nil)
    }

    @objc func addTargetShowAlertEmptyTextField () {
        self.present(alertControllerCheckEmptyText, animated: true, completion: nil)
    }
}

extension HabitViewController: UIColorPickerViewControllerDelegate {

    internal func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
    let color = viewController.selectedColor
    colorChangeButton.backgroundColor = color
    setColor = color
    }

}
