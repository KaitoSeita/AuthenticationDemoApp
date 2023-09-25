//
//  SignInTopPresenter.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/25.
//

import Foundation
import SwiftUI

final class SignInTopPresenter: ObservableObject {
    
    func onTapSignInWithEmailButton() -> AnyView? {
        return SignInTopRouter().setDestination(selection: .email)
    }
    
    func onTapSignInWithGoogleButton() -> AnyView? {
        return SignInTopRouter().setDestination(selection: .google)
    }
    
    func onTapSignInWithAppleButton() -> AnyView? {
        return SignInTopRouter().setDestination(selection: .apple)
    }
}
