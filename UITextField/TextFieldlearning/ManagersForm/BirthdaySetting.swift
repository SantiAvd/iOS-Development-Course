//
//  BirthdaySetting.swift
//  TextFieldlearning
//
//  Created by Alexandr on 06.07.2024.
//

import Foundation


final class BirthdayManager {
    
    private let maxCountForBirthday = 8
    private let regex = try! NSRegularExpression(pattern: "[\\+\\s-\\(\\)]", options: .caseInsensitive)
    
    func birthdaySet(date: String) -> String {
        
        let range = NSString(string: date).range(of: date)
        var birthNum = regex.stringByReplacingMatches(in: date, options: [], range: range, withTemplate: "")
        
        if birthNum.count > maxCountForBirthday {
            let maxIndex = birthNum.index(birthNum.startIndex, offsetBy: maxCountForBirthday)
            birthNum = String(birthNum[birthNum.startIndex..<maxIndex])
        }
        
        let maxIndex = birthNum.index(birthNum.startIndex, offsetBy: birthNum.count)
        let regRange = birthNum.startIndex..<maxIndex
        
        if birthNum.count > 2 {
            let pattern = "(\\d{2})(\\d{2})(\\d+)"
            birthNum = birthNum.replacingOccurrences(of: pattern, with: "$1.$2.$3", options: .regularExpression, range: regRange)
            }
        print("birthNum - \(birthNum)")
            return birthNum
    }
}
