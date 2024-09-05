//
//  User.swift
//  TableViewStaticCell
//
//  Created by Alexandr on 10.08.2024.
//

import Foundation

struct User: Codable {
    let name: String
    let surName: String
    let age: String
    let phoneNumber: String
    let mailAddres: String
    let gender: Gender
}
