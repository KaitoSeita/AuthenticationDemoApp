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
    @Published var email = "example@email.com"
    @Published var password = "aaaaaa"
    @Published var userName = "Kaito Seita"
    @Published var birthdayDate = Calendar(identifier: .gregorian).date(from: DateComponents(year: 2001, month: 7, day: 29))!
}
