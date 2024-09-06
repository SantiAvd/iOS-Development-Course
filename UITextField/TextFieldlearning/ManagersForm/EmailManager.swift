//
//  EmailManager.swift
//  TextFieldlearning
//
//  Created by Alexandr on 07.07.2024.
//

import Foundation

final class EmailManager {
    
    func validEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

