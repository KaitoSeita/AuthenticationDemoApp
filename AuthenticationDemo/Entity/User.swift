//
//  User.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/10/02.
//

import SwiftUI

struct User: Identifiable {
    var id: String
    var displayName: String?
    var email: String?
}

struct GIDUser: Identifiable {
    var id: String?
    var idToken: String?
    var accessToken: String?
}

class SignUpUser: ObservableObject {
    @Published var email = "sample@email.com"
    @Published var password = "aaaaaaa"
    @Published var userName = "sample"
    @Published var birthdayDate = Calendar(identifier: .gregorian).date(from: DateComponents(year: 2000, month: 1, day: 1))!
}
