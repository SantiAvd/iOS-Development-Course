//
//  ManagerForm.swift
//  TableViewStaticCell
//
//  Created by Alexandr on 14.08.2024.
//

import Foundation

final class AuthManagerForForm {

    private let maxCountForBirthday = 10
    private let maxCountForNumber = 11
    
    private let regex: NSRegularExpression

        init() {
            do {
                regex = try NSRegularExpression(pattern: "[\\+\\s-\\(\\)\\/\\:\\;\\$\\&\\@]", options: .caseInsensitive)
            } catch {
                // Обработка ошибки, если регулярное выражение не удалось создать
                print("Не удалось создать регулярное выражение: \(error.localizedDescription)")
                // Здесь можно обработать ошибку, например, завершить инициализацию
                fatalError("Инициализация не удалась.")
            }
        }

    
    private var birthday = ""
    private var phoneNumber = ""
    private var emailAddress = ""
    
    func setPhoneNumber(number: String, shouldRemove: Bool) -> String {

        guard !(shouldRemove && number.count <= 2) else {
            return "+"
        }
        
        let range = NSString(string: number).range(of: number)
        var number = regex.stringByReplacingMatches(in: number, options: [], range: range, withTemplate: "")
        
        if number.count > maxCountForNumber {
            let maxIndex = number.index(number.startIndex, offsetBy: maxCountForNumber)
            number = String(number[number.startIndex..<maxIndex])
        }
        
        if shouldRemove {
            let maxIndex = number.index(number.startIndex, offsetBy: number.count - 1)
            number = String(number[number.startIndex..<maxIndex])
        }
        
        let maxIndex = number.index(number.startIndex, offsetBy: number.count)
        let regRange = number.startIndex..<maxIndex
        
        if number.count  < 7 {
            let pattern = "(\\d)(\\d{3})(\\d+)"
            number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3", options: .regularExpression, range: regRange)
        } else {
            let pattern = "(\\d)(\\d{3})(\\d{3})(\\d{2})(\\d+)"
            number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3-$4-$5", options: .regularExpression, range: regRange)
        }
        
        return "+" + number
    }
    
    func validEmail(_ email: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailPred.evaluate(with: email)
    }
    
    func birthdaySet(date: String, shouldRemove: Bool) -> String {
        
        let range = NSString(string: date).range(of: date)
        var birthDate = regex.stringByReplacingMatches(in: date, options: [], range: range, withTemplate: "")
        
        if birthDate.count > maxCountForBirthday {
            let maxIndex = birthDate.index(birthDate.startIndex, offsetBy: maxCountForBirthday)
            birthDate = String(birthDate[birthDate.startIndex..<maxIndex])
        }
        
        if shouldRemove {
            let maxIndex = birthDate.index(birthDate.startIndex, offsetBy: birthDate.count - 1)
            birthDate = String(birthDate[birthDate.startIndex..<maxIndex])
        }
        
        let maxIndex = birthDate.index(birthDate.startIndex, offsetBy: birthDate.count)
        let regRange = birthDate.startIndex..<maxIndex
        
        if birthDate.count > 2 {
            let pattern = "(\\d{2})(\\d{2})(\\d+)"
            birthDate = birthDate.replacingOccurrences(of: pattern, with: "$1.$2.$3", options: .regularExpression, range: regRange)
            } // 🔴 Скобка
        
        return birthDate
    }
}
