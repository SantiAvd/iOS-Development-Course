//
//  AuthViewAction.swift
//  TableViewStaticCell
//
//  Created by Alexandr on 14.08.2024.
//

import Foundation

enum AuthViewAction {
    case textEntered(text: String, textFieldType: AuthTextFieldType, shouldRemove: Bool)
}
