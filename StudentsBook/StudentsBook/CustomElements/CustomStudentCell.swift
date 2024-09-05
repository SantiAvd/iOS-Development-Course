//
//  CustomStudentCell.swift
//  StudentsBook
//
//  Created by Alexandr on 22.08.2024.
//

import UIKit

class CustomStudentCell: UITableViewCell {
    
    static  let id = "\(CustomStudentCell.self)"
    var nameLabel = UILabel()
    var surNameLabel = UILabel()
    var gradeLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabels()
        colorGrade()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private func setupLabels() {
        [nameLabel, surNameLabel, gradeLabel].forEach {
            $0.font = .systemFont(ofSize: 20)
            $0.textColor = .black
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
       
       makeConstraints()
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            surNameLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 5),
            surNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            surNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            gradeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            gradeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            gradeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func colorGrade() {
        switch gradeLabel.text {
        case "2": contentView.backgroundColor = .red.withAlphaComponent(0.6)
        case "3": contentView.backgroundColor = .gray.withAlphaComponent(0.6)
        case "4": contentView.backgroundColor = .green.withAlphaComponent(0.6)
        case "5": contentView.backgroundColor = .yellow.withAlphaComponent(0.6)
        default: break
        }
    }
    
    func configurCell(student: Student) {
        nameLabel.text =  student.name
        surNameLabel.text = student.surName
        gradeLabel.text = "\(student.grade)"
    }
}
