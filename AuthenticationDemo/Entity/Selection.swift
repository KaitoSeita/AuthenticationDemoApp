//
//  Selection.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/10/02.
//

import SwiftUI

enum AuthenticationTopSelection {
    case signIn
    case signUp
}

enum SignUpSelection {
    case email
    case userInfomation
    case confirmation
}

struct AgeSelection: Hashable {
    var age: Int
    var isSelected: Bool
}
