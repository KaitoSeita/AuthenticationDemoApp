//
//  UserInfo.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/06.
//

import Foundation

struct User: Identifiable, Equatable {
    var id: String
    var displayName: String?
    var email: String?
}
