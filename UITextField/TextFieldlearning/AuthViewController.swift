//
//  ViewController.swift
//  TextFieldlearning
//
//  Created by Alexandr on 25.06.2024.
//

import UIKit

protocol AuthViewProtocol: AnyObject  {
    func display(_ display: DisplayText)
}

final class AuthViewController: UIViewController {
  
    var newText = ""
    
    private let phoneManag = AuthManagerForForm()
    private let nameField = CustomTextField(authTextFieldType: AuthTextFieldType.name)
    private let secondNameField = CustomTextField(authTextFieldType: AuthTextFieldType.secondName)
    private let birthdayField = CustomTextField(authTextFieldType: AuthTextFieldType.birthday)
    private let phoneNumberField = CustomTextField(authTextFieldType: AuthTextFieldType.phoneNumber)
    private let emailField = CustomTextField(authTextFieldType: AuthTextFieldType.email)
    
    private let loginButton = UIButton()
    private var interactor = AuthPresenter()
    
    private let infoLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.numberOfLines = 4
        textLabel.textColor = UIColor(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        textLabel.font = UIFont(name: "Comfortaa- Bold", size: 16)
        textLabel.text = "Information"
        return textLabel
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        interactor.viewForm = self
    }
    
   private  func setupStack() {
        [nameField, secondNameField,birthdayField,phoneNumberField,emailField].forEach {
            mainStackView.addArrangedSubview($0)
          }
    }
    
    private func setupView() {
        view.backgroundColor = .black
        addSubViews()
        setUpLayout()
        setupStack()
        setupButton()
    }
    
    private func setupButton() {
        
        loginButton.setTitle("Log In", for: .normal)
        loginButton.setTitleColor(UIColor(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), for: .normal)
        loginButton.backgroundColor =  #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        loginButton.layer.borderColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        loginButton .layer.borderWidth = 1
        loginButton.layer.cornerRadius =  10
        loginButton.addTarget(self, action: #selector(setLabelByButton), for: .touchUpInside)
    }
    
    private func addSubViews() {
        [mainStackView, loginButton, infoLabel].forEach {
            view.addSubview($0)
        }
        
        [nameField, secondNameField,birthdayField,phoneNumberField,emailField].forEach { $0.delegate = self
        }
    }
    
    private func setUpLayout() {
        [mainStackView, loginButton, infoLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            mainStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            mainStackView.heightAnchor.constraint(equalToConstant: 200),
            
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            loginButton.heightAnchor.constraint(equalToConstant: 30),
            
            infoLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            infoLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            infoLabel.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 15),
            infoLabel.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -5)
        ])
    }
    
    @objc func setLabelByButton(sender: UIButton) {
        infoLabel.text = newText
    }
}

// MARK: AuthViewProtocol

extension AuthViewController: AuthViewProtocol {
    
    internal func display(_ displayText: DisplayText) {
        newText = displayText.displaytext
    }
}

// MARK: TextFieldDelegate

 extension AuthViewController: UITextFieldDelegate {
     
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         
         switch textField{
         case nameField: secondNameField.becomeFirstResponder()
         case secondNameField: birthdayField.becomeFirstResponder()
         case birthdayField: phoneNumberField.becomeFirstResponder()
         case phoneNumberField: emailField.becomeFirstResponder()
         case emailField: textField.resignFirstResponder()
         default:
             textField.resignFirstResponder()
         }
         return true
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
            let customTextField = textField as? CustomTextField
            else { return false }
        let fullString = text + string
         print("\(range)")
    return interactor.handleAction(.textEntered(text: fullString, textFieldType: customTextField.authTextFieldType, shouldRemove: range.length == 1))
     }
}
