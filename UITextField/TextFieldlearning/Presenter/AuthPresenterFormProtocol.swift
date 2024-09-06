//
//  PresenterForm.swift
//  TextFieldlearning
//
//  Created by Alexandr on 06.07.2024.
//

import Foundation

protocol AuthPresenterFormProtocol {
    func handleAction(_ action: AuthViewAction) -> Bool
}

class AuthPresenter {
    
    weak var viewForm: AuthViewProtocol?
    private var storage = Storage.initial
    private var finalString = ""
    private var nameString = ""
    private var secondNameString = ""
    private  var birthdayString = ""
    private var phoneNumber = ""
    private var emailString = ""
    private var email = Bool()
    private var birthManager = AuthManagerForForm()
    private var phoneNumberManager = AuthManagerForForm()
    private var emailManager = AuthManagerForForm()
    private var shouldRemove = Bool()
    
    private func settingsForName(string: String) -> Bool {
        
        if string.count > 20 {
            return false
        }
        
        let nonLettersSet = CharacterSet.letters.inverted
        if let _ = string.rangeOfCharacter(from: nonLettersSet) {
            return false
        } else {
            storage.name = string
        }
        
        nameString = storage.name
        makeFinalString()
        return true
    }
    
    private func settingsForSecondName(string: String) -> Bool {
        
        if string.count > 25 {
            return false
        }
        
        let nonLettersSet = CharacterSet.letters.inverted
        if let _ = string.rangeOfCharacter(from: nonLettersSet) {
            return false
        } else {
            storage.secondName = string
        }
        
        secondNameString = storage.secondName
        makeFinalString()
        return true
    }
    
    private func settingPhoneNumber(number: String, shoulRemove: Bool) -> Bool {
        
        if number.count > 11 {
            return false
        }
        
        let decimal = CharacterSet.decimalDigits.inverted
        if let _ = number.rangeOfCharacter(from: decimal) {
            return false
        } else {
            storage.phoneNumber = phoneNumberManager.setPhoneNumber(number: number, shouldRemove: shoulRemove)
        }
        
        phoneNumber = storage.phoneNumber
        makeFinalString()
        return true
    }
    
    private func settingsForBirthday(birthday: String, shouldRemove: Bool) -> Bool {
        
        if birthday.count > 8 {
            return false
        }
        
        let decimal = CharacterSet.decimalDigits.inverted
        if let _ = birthday.rangeOfCharacter(from: decimal) {
            return false
        } else {
            storage.birthday = birthManager.birthdaySet(date: birthday, shouldRemove: shouldRemove)
        }
        
        birthdayString = storage.birthday
        makeFinalString()
        return true
    }
    
    private func setEmail(mail: String) -> Bool {
        
        if mail.count > 30 {
            return false
        }
        
        storage.email = emailManager.validEmail(mail)
        email = storage.email
      
        if email {
            emailString = mail
        } else {
            emailString = "Not Valid Email"
        }
        
        makeFinalString()
        return true
    }

    private func makeFinalString() {
        finalString = "\(nameString) \(secondNameString) \(phoneNumber) \(birthdayString) \(emailString)"
        updateView(finalString)
    }
    
    private func updateView(_ str: String) {
        viewForm?.display(DisplayText(displaytext: str))
    }
}

// MARK: AuthPresenterFormProtocol

extension AuthPresenter: AuthPresenterFormProtocol {
    func handleAction(_ action: AuthViewAction) -> Bool  {
        switch action {
        case .textEntered(let text, let textFieldType, let shouldRemove):
            switch (text, textFieldType) {
            case (_ , .name): return settingsForName(string: text)
            case (_, .secondName):
                return settingsForSecondName(string: text)
            case (_, .birthday):
               return settingsForBirthday(birthday: text, shouldRemove: shouldRemove)
            case (_, .phoneNumber):
            return settingPhoneNumber(number: text, shoulRemove: shouldRemove)
            case (_, .email):
                return setEmail(mail: text)
            }
        case .settupButtonTapped:
            makeFinalString()
        }
        return true
    }
}


