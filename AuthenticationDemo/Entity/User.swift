//
//  User.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/10/02.
//

import Foundation

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
