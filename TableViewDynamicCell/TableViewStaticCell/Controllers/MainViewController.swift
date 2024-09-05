//
//  ViewController.swift
//  TableViewStaticCell
//
//  Created by Alexandr on 17.07.2024.
//

import UIKit

final class MainViewController: UIViewController {

    private let myTableView = UITableView()
    private var restoreButton = UIButton(type: .custom)
    
    private var users = [User]()
    private var currentUsers: [User] = []
    
    private var isFirstVisit = true
    
    private var user: User? = nil {
        didSet {
            guard let user = user else { return }
            if users.isEmpty {
                isFirstVisit = false
            }
            users.append(user)
            currentUsers = users
            myTableView.reloadData()
        }
    }
    
    private(set) var addUser: (User) -> () = { _ in }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Пользователи"
        view.backgroundColor = .white
        myTableView.backgroundColor = .white
        configureElements()
        makeConstraint()
        configureNavBar()
        
        addUser = { [weak self] user in
            self?.user = user // сюда как раз приходит юзер со второго экрана
        }

        myTableView.reloadData()
    }
    
    @objc func topAddButton() {
        let addUserVC = AddUserViewController(addUser: addUser)
        navigationController?.pushViewController(addUserVC, animated: true)
    }
}


//MARK: MainViewController Configuration
extension MainViewController {
    
    private func configureNavBar() {
        navigationController?.navigationBar.tintColor = .blue
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(topAddButton))
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationItem.standardAppearance = appearance
    }
    
    private func configureElements() {

        myTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        myTableView.delegate = self
        myTableView.dataSource = self
        
        restoreButton.setTitle("Вернуть данные", for: .normal)
        restoreButton.addTarget(self, action: #selector(restoreButtonPressed), for: .touchUpInside)
        restoreButton.backgroundColor = .systemBlue
        restoreButton.layer.cornerRadius = 10
        
        view.addSubview(myTableView)
        view.addSubview(restoreButton)
      }
    
   @objc func restoreButtonPressed(_ sender: Any) {
       users = currentUsers
       // 🟡 Уехал код вправо
        myTableView.reloadData()
    }
      
    private func makeConstraint() {
        restoreButton.translatesAutoresizingMaskIntoConstraints = false
        myTableView.translatesAutoresizingMaskIntoConstraints = false
          
        NSLayoutConstraint.activate([
            myTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            myTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            myTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            myTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            restoreButton.heightAnchor.constraint(equalToConstant: 50),
            restoreButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            restoreButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            restoreButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
        ])
    }
}

//MARK: UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFirstVisit ? 1 : users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell

        if isFirstVisit {
            cell.startOnBoard()
        } else {
            cell.user = users[indexPath.row]
            if users.count == indexPath.row + 1 {
                return cell
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if !isFirstVisit {
            users.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}

//MARK: UITableDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
