//
//  AuthenticationTopPresenter.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/25.
//

import SwiftUI

final class AuthenticationTopPresenter: ObservableObject {
    
    func onTapSignInButton() -> AnyView? {
        return AuthenticationTopRouter().setDestination(selection: .signIn)
    }
    
    func onTapSignUpButton() -> AnyView? {
        return AuthenticationTopRouter().setDestination(selection: .signUp)
    }
}
