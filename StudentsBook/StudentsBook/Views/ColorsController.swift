//
//  ColorsController.swift
//  StudentsBook
//
//  Created by Alexandr on 31.08.2024.
//

import UIKit

final class ColorsController: UIViewController {

    let id = "\(ColorsController.self)"
    let colorTable = UITableView(frame: .zero, style: .insetGrouped)
    var colorArray: [RandomColor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
       setupTable()
    }
    
    private func setupTable() {
        view.addSubview(colorTable)
        colorTable.separatorStyle = .singleLine
        colorTable.register(UITableViewCell.self, forCellReuseIdentifier: id)
        colorTable.dataSource = self
        colorTable.translatesAutoresizingMaskIntoConstraints = false
        
        for _ in 0...1000 {
            colorArray.append(RandomColor())
        }
        
        makeConstraint()
    }
    
    private func makeConstraint() {
        NSLayoutConstraint.activate([
            colorTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            colorTable.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            colorTable.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            colorTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: UITableViewDataSource

extension ColorsController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1000
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = UITableViewCell(style: .default, reuseIdentifier: id)
        let colorComponent = colorArray[indexPath.row]
        let red = String(format: "%.2f", colorComponent.red)
        let green = String(format: "%.2f", colorComponent.green)
        let blue = String(format: "%.2f", colorComponent.blue)
        var cellContent = newCell.defaultContentConfiguration()
        cellContent.text = "R - \(red); G - \(green); B - \(blue); number - \(indexPath.row + 1)"
        newCell.contentConfiguration = cellContent
        newCell.backgroundColor = UIColor(red: colorComponent.red, green: colorComponent.green, blue: colorComponent.blue, alpha: 1)
        
        return newCell
    }
}
