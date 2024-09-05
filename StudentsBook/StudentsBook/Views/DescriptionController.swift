//
//  DescriptionController.swift
//  StudentsBook
//
//  Created by Alexandr on 31.08.2024.
//

import UIKit

final class DescriptionController: UIViewController {
    
    let textForLabel: String = """
    Студент:
        5. Теперь создайте класс, который содержит цвет и нейм.
        6. В viewDidLoad сгенерируйте 1000 объектов такого класса по принципу из ученика
        7. Положите их в массив и отобразите в таблице
        8. В этом случае когда вы будете листать назад вы увидете те же ячейки, что там и были, а не новые рандомные
    
    Мастер:
        9. Возвращаемся к слудентам. Сгенерируйте 20-30 разных студентов.
        10. В таблице создавайте не дефаулт ячейку а Value1. В этом случае у вас появится еще одна UILabel - detailLabel.
        11. В textLabel пишите имя и фамилию студента, а в detailLabel его средний бал.
        12. Если средний бал низкий - окрашивайте имя студента в красный цвет
        13. Отсортируйте студентов в алфовитном порядке и отобразите в таблице
    
    Супермен:
        14. Средний бал для студентов ставьте рандомно от 2 до 5
        15. После того, как вы сгенерировали 30 студентов вам надо их разбить на группы: отличники, хорошисты, троечники и двоечники
        16. Каждая группа это секция с соответствующим названием.
        17. Студенты внутри своих групп должны быть в алфовитном порядке
        18. Отобразите группы студентов с их оченками в таблице.
    
    Imposible:
        19. Добавьте к супермену еще одну секцию, в которой вы отобразите 10 моделей цветов из задания Студент.
        20. Помните, это должно быть 2 разных типа ячеек Value1 для студентов и Default для цветов.
    """
    
    let ruleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        label.textColor = .black
        label.backgroundColor = .cyan
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.padding(top: 10, left: 10, bottom: 10, right: 10)
        return label
        }()
        
    override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            makeConstraint()
            alertAction()
        }
    
    private func makeConstraint() {
        ruleLabel.text = textForLabel
        view.addSubview(ruleLabel)
        
        NSLayoutConstraint.activate([
            ruleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ruleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ruleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ruleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40)
        ])
    }
    
    private func alertAction() {
        let alert = UIAlertController(title: "Внимание", message: "Этот текст в котором написано задание, большой ", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Ок", style: .cancel) { _ in
            let alert = UIAlertController(title: "Хотел добавить", message: "Читать если лень, не обязательно", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Спасибо", style: .cancel) { _ in
                let alert = UIAlertController(title: "Внимание!", message: "Спасибо за внимание)", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "Закройся уже", style: .destructive)
                alert.addAction(cancel)
                self.present(alert, animated: true)
            }
            alert.addAction(yesAction)
            self.present(alert, animated: true)
        }
        
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
    
}

//MARK: Extension UILabel for Padding
    extension UILabel {
        func padding(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
            let insets: UIEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
            drawText(in: bounds.inset(by: insets))
        }

        override open func draw(_ rect: CGRect) {
            super.draw(rect)
        }
    }
