//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Татьяна Жукова on 20.04.2023.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        title = "Информация"

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        let firstText = NSAttributedString(string: "Привычка за 21 день\n\n", attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 18, weight: .semibold), NSAttributedString.Key.paragraphStyle:paragraphStyle])
        let secondText = NSAttributedString(string: """
            Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:\n
            1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.\n
            2. Выдержать 2 дня в прежнем состоянии самоконтроля.\n
            3. Отметить в дневнике первую неделю изменений и подвести первые итоги - что оказалось тяжело, что - легче, с чем еще предстоит серьезно бороться.\n
            4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодаления и человек сможет больше работать в сторону принятия положительных качеств.\n
            5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.\n
            6. На 90-й день соблюдения техники все лишнее из "прошлой жизни" перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся\n
            Источник: psychbook.ru
            """,attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.paragraphStyle:paragraphStyle])
        let allText = NSMutableAttributedString()
        allText.append(firstText)
        allText.append(secondText)

        let infoTextView = UITextView()
        infoTextView.translatesAutoresizingMaskIntoConstraints = false
        infoTextView.attributedText = allText
        infoTextView.textAlignment = .left

        self.view.addSubview(infoTextView)

        infoTextView.textContainerInset = UIEdgeInsets(top: 22, left: 16, bottom: 0, right: 16)

        NSLayoutConstraint.activate([
            infoTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            infoTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            infoTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            infoTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}
