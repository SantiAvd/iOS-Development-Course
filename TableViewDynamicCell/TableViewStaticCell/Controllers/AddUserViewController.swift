//
//  AddUserViewController.swift
//  TableViewStaticCell
//
//  Created by Alexandr on 12.08.2024.
//

import UIKit

class AddUserViewController: UIViewController {
    
    let manager = AuthManagerForForm()
    
    private var validMail = Bool()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let nameField = CustomTextField(authTextFieldType: .name)
    private let surNameField = CustomTextField(authTextFieldType: .secondName)
    private let ageField = CustomTextField(authTextFieldType: .birthday)
    private let numberPhoneField = CustomTextField(authTextFieldType: .phoneNumber)
    private let mailAddresField = CustomTextField(authTextFieldType: .email)
    
    private var genderSegment = UISegmentedControl()
    private let addUserButton = UIButton(type: .custom)
    
    private let arrayGenderSegments =  ["Мужской", "Женский"]
    private var gender: Gender?

    private let addUser: (User) -> ()
    
    init(addUser: @escaping (User) -> ()) {
        self.addUser = addUser
        super.init(nibName: nil, bundle: Bundle.main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        configureNavigationBar()
        configureElements()
        addSubviews()
        makeConstraints()
    }
    
    @objc func routeToSecondVC() {
        let user = User(
            name: nameField.text ?? "",
            surName: surNameField.text ?? "",
            age: ageField.text ?? "",
            phoneNumber: numberPhoneField.text ?? "",
            mailAddres: validMail ? (mailAddresField.text ?? "") : "Not Valid Email",
            gender: gender ?? .male
        )
    
        addUser(user)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func changeGenderColor(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: changeColorGender(gender: .male)
            gender = .male
        case 1: changeColorGender(gender: .female)
            gender = .female
        default:
            break
        }
    }
}

// MARK: Configuration
private extension AddUserViewController {
    
    func configureNavigationBar() {
        title = "Новый пользователь"
        navigationController?.navigationBar.topItem?.backButtonTitle = "Назад"
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.standardAppearance = appearance
    }
    
    func addSubviews() {
        [mainStackView, addUserButton, genderSegment].forEach { view.addSubview($0) }
    }
    
    func configureElements() {
        
        [nameField, surNameField, ageField, numberPhoneField, mailAddresField].forEach {
            mainStackView.addArrangedSubview($0)
        }
    
        [nameField, surNameField, ageField, numberPhoneField, mailAddresField].forEach {
            $0.delegate = self
        }
        
        addUserButton.setTitle("Добавить", for: .normal)
        addUserButton.addTarget(self, action: #selector(routeToSecondVC), for: .touchUpInside)
        addUserButton.backgroundColor = .systemBlue
        addUserButton.layer.cornerRadius = 10
        
        genderSegment = UISegmentedControl(items: arrayGenderSegments)
        genderSegment.selectedSegmentIndex = UISegmentedControl.noSegment
        genderSegment.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Comfortaa-Medium", size: 18) as Any, NSAttributedString.Key.foregroundColor : UIColor.black], for: .normal)
        genderSegment.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Comfortaa-Medium", size: 24) as Any, NSAttributedString.Key.foregroundColor : UIColor.black], for: .selected)
        genderSegment.addTarget(self, action: #selector(changeGenderColor), for: .valueChanged)
    }
    
    func makeConstraints() {
        [mainStackView, addUserButton, genderSegment].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            addUserButton.heightAnchor.constraint(equalToConstant: 50),
            addUserButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            addUserButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            addUserButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            
            genderSegment.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 10),
            genderSegment.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            mainStackView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    func changeColorGender(gender: Gender) {
        switch gender {
        case .male:
            UIView.animate(withDuration: 0.2) {
                self.view.backgroundColor = UIColor(red: 0/255, green: 191/255, blue: 255/255, alpha: 1)
            }
        case .female:
            UIView.animate(withDuration: 0.2) {
                self.view.backgroundColor = UIColor(red: 255/255, green: 103/255, blue: 144/255, alpha: 1)
            }
        }
    }
}

//MARK: UITextFieldDelegate

extension AddUserViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameField: surNameField.becomeFirstResponder()
        case surNameField: ageField.becomeFirstResponder()
        case ageField: numberPhoneField.becomeFirstResponder()
        case numberPhoneField: mailAddresField.becomeFirstResponder()
        case mailAddresField: textField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if textField.isEditing {
            return true
        }
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard
            let text = textField.text,
            let customtextField = textField as? CustomTextField
        else { return false }
        let nonLettersSet = CharacterSet.letters.inverted
        let allowedCharacters = CharacterSet.decimalDigits
         let fullstring = text + string
        switch customtextField.authTextFieldType {
        case .name , .secondName:
            if fullstring.count > 25 {
                return false
            }
            if let _ = fullstring.rangeOfCharacter(from: nonLettersSet) {
                return false
            }
        case .birthday:
            let characterSet = CharacterSet(charactersIn: string)
            
            if allowedCharacters.isSuperset(of: characterSet) {
                textField.text = manager.birthdaySet(date: fullstring, shouldRemove: range.length == 1)
            }
            return false
        case .phoneNumber:
            let characterSet = CharacterSet(charactersIn: string)
        
            if allowedCharacters.isSuperset(of: characterSet) {
                textField.text  =  manager.setPhoneNumber(number: fullstring, shouldRemove: range.length == 1)
            }
            return false
        case .email:
            validMail = manager.validEmail(fullstring)
        }
        
        return true
    }
}
