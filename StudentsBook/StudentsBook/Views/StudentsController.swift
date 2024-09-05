//
//  StudentsController.swift
//  StudentsBook
//
//  Created by Alexandr on 31.08.2024.
//

import UIKit
final class StudentsController: UIViewController {

    let studentTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    var studentsSource = Source.makeStudents()
    var colorArray: [RandomColor] = []
    var currentStudent: [[Student]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupTableView()
        makeCurrentStudents()
    }
    
    private func setupTableView() {

        view.addSubview(studentTableView)
        studentTableView.separatorStyle = .singleLine
        studentTableView.register(CustomStudentCell.self, forCellReuseIdentifier: CustomStudentCell.id)
        studentTableView.dataSource = self
        studentTableView.translatesAutoresizingMaskIntoConstraints = false
        makeConstraints()
        fillRandomColor()
    }
    
    private func makeCurrentStudents() {
        studentsSource.enumerated().forEach { indexStud, student in
            var currentStudent = student
            currentStudent.grade = Int.random(in: 2...5)
            studentsSource.remove(at: indexStud)
            studentsSource.insert(currentStudent, at: indexStud)
        }
    
        currentStudent = makeStudentsGroupe(students: studentsSource)
    }
    
   private func makeStudentsGroupe(students: [Student]) -> [[Student]] {
        let lowMark = students.filter { $0.grade == 2 }.sorted { $0.name < $1.name }
        let mediorceMark = students.filter { $0.grade == 3 }.sorted { $0.name < $1.name }
        let goodMark = students.filter { $0.grade == 4 }.sorted { $0.name < $1.name }
        let exelentMark = students.filter { $0.grade == 5 }.sorted { $0.name < $1.name }
        return [exelentMark, goodMark, mediorceMark, lowMark]
    }
    
    private func fillRandomColor() {
        for _ in 0...9 {
            colorArray.append(RandomColor())
        }
    }
    
   private func makeConstraints() {
        NSLayoutConstraint.activate([
            studentTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            studentTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            studentTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            studentTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: UITableViewDataSource

extension StudentsController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Отличники"
        case 1: return "Хорошисты"
        case 2: return "Троечники"
        case 3: return "Двоечники"
        default: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1, 2, 3: return currentStudent[section].count
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: CustomStudentCell.id, for: indexPath) as? CustomStudentCell else { return UITableViewCell() }
        
            cell.configurCell(student: currentStudent[indexPath.section][indexPath.row])
            cell.colorGrade()
        
        return cell
    }
}


