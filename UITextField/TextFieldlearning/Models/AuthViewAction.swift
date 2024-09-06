//
//  EnumTextFieds.swift
//  TextFieldlearning
//
//  Created by Alexandr on 06.07.2024.
//

import Foundation

enum AuthViewAction {
    case textEntered(text: String, textFieldType: AuthTextFieldType, shouldRemove: Bool)
    case settupButtonTapped
}
