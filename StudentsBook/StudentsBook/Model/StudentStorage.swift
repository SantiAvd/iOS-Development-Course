//
//  StudentStorage.swift
//  StudentsBook
//
//  Created by Alexandr on 26.08.2024.
//

import Foundation

struct Student {
    let name: String
    let surName: String
    var grade = 2
}

struct Source {
    
    static func makeStudents() -> [Student] {
       [
        .init(name: "Владислав", surName: "Шевченко"),
        .init(name: "Карим", surName: "Бенземович"),
        .init(name: "Моника", surName: "Белуга"),
        .init(name: "Петр", surName: "Крестсов"),
        .init(name: "Александр", surName: "Абрамов"),
        .init(name: "Метью", surName: "Макдонахи"),
        .init(name: "Ян", surName: "Полуян"),
        .init(name: "Анна", surName: "Шайн"),
        .init(name: "Николай", surName: "Йокич"),
        .init(name: "Степан", surName: "Карин"),
        .init(name: "Стив", surName: "Рабочий"),
        .init(name: "Анастасия", surName: "Волкова"),
        .init(name: "Надежда", surName: "Закадышева"),
        .init(name: "Елена", surName: "Ванга"),
        .init(name: "Владимир", surName: "Пудинг"),
        .init(name: "Алексей", surName: "Ущербаков"),
        .init(name: "Андрей", surName: "Мазаноф"),
        .init(name: "Роман", surName: "Карабей"),
        .init(name: "Мария", surName: "Красец"),
        .init(name: "Параскева", surName: "Арабеска"),
       ]
    }
}
