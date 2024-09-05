//
//  CustomTableViewCells.swift
//  TableViewStaticCell
//
//  Created by Alexandr on 06.08.2024.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "id\(CustomTableViewCell.self)"

    private let nameLabel = UILabel()
    private let surName = UILabel()
    private let age = UILabel()
    private let phoneNumber = UILabel()
    private let emailAddres = UILabel()
    private let gender = UILabel()
    
    var user: User? {
        didSet {
            nameLabel.text = user?.name
            surName.text = user?.surName
            age.text = user?.age
            phoneNumber.text = user?.phoneNumber
            emailAddres.text = user?.mailAddres
            switch user?.gender {
            case .male: gender.text = "Мужчина"
            case .female: gender.text = "Женщина"
            case .none:
                gender.text = "Не определено"
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
        makeConstraint()
    }
    

    func startOnBoard() {
        nameLabel.text = "Нет пользователей"
        surName.text = ""
        age.text = ""
        phoneNumber.text = ""
        emailAddres.text = ""
        gender.text = ""
        [nameLabel, surName, age, phoneNumber, emailAddres, gender].forEach {
            $0.alpha = 0
        }
        UIView.animate(withDuration: 1.5) { [self] in
            [nameLabel, surName, age, phoneNumber, emailAddres, gender].forEach {
                $0.alpha = 1
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private func addSubview() {
       
       [nameLabel, surName].forEach {
           $0.font = UIFont(name: "Comfortaa-Medium", size: 18)
           $0.textColor = .black
           contentView.addSubview($0)
           $0.translatesAutoresizingMaskIntoConstraints = false
       }
       
       [age, phoneNumber, emailAddres, gender].forEach {
           $0.font = UIFont(name: "Comfortaa-Medium", size: 14)
           $0.textColor = .black
           contentView.addSubview($0)
           $0.translatesAutoresizingMaskIntoConstraints = false
       }
    }
    
    private func makeConstraint() {
        NSLayoutConstraint.activate([
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),

            surName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            surName.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 5),
            surName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),

            age.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            age.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 1),
            age.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            
            gender.leftAnchor.constraint(equalTo: age.rightAnchor, constant: 5),
            gender.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 1),
            gender.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            
            phoneNumber.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            phoneNumber.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            
            emailAddres.topAnchor.constraint(equalTo: phoneNumber.bottomAnchor, constant: 1),
            emailAddres.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            emailAddres.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2)
        ])
    }
}
