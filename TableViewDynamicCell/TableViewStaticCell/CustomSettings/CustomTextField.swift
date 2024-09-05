//
//  CustomTextField.swift
//  TableViewStaticCell
//
//  Created by Alexandr on 06.08.2024.
//

import Foundation

import UIKit

enum AuthTextFieldType {
    case name
    case secondName
    case birthday
    case phoneNumber
    case email
    
    var placeholder: String {
        switch self {
        case .name:
            "Введите имя"
        case .secondName:
            "Введите фамилию"
        case .birthday:
            "Введите дату рождения"
        case .phoneNumber:
            "Номер телефона"
        case .email:
            "Введите e-mail"
        }
    }
}

final class CustomTextField: UITextField {
    
    private let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 40)
     let authTextFieldType: AuthTextFieldType

    init(frame: CGRect = .zero, authTextFieldType: AuthTextFieldType){
        self.authTextFieldType = authTextFieldType
        super.init(frame: frame)
        setupTextField(authTextFieldType: authTextFieldType)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    private func setupTextField(authTextFieldType: AuthTextFieldType) {
        
        switch authTextFieldType {
        case .name:
            attributedPlaceholder = NSAttributedString(string: authTextFieldType.placeholder, attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
            keyboardType = .default
            returnKeyType = .next
            autocapitalizationType = .words
        case .secondName:
            attributedPlaceholder = NSAttributedString(string: authTextFieldType.placeholder, attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
            keyboardType = .default
            returnKeyType = .next
            autocapitalizationType = .words
        case .birthday:
            attributedPlaceholder = NSAttributedString(string: authTextFieldType.placeholder, attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
            keyboardType = .numbersAndPunctuation
            returnKeyType = .next
            autocapitalizationType = .none
        case .phoneNumber:
            attributedPlaceholder = NSAttributedString(string: authTextFieldType.placeholder, attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
            keyboardType = .numbersAndPunctuation
            returnKeyType = .next
            autocapitalizationType = .none
        case .email:
            attributedPlaceholder = NSAttributedString(string: authTextFieldType.placeholder, attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
            keyboardType = .emailAddress
            returnKeyType = .done
            autocapitalizationType = .none
        }
        
        autocorrectionType = .no
        clearButtonMode = .always
        keyboardAppearance = .dark
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 11
        textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        font = UIFont(name: "Comfortaa-Medium", size: 18)
        layer.cornerRadius = 10
        layer.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.6).cgColor
        layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        layer.borderWidth = 1
    }
}
