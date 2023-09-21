//
//  SignInTopRouter.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/17.
//

import Foundation
import SwiftUI

struct SignInTopRouter {
    
    func setDestination(selection: SignInTopSelection) -> AnyView? {
        
        switch selection {
        case .email:
            return AnyView(SignInWithEmailView(interactor: interactor))
        case .google:
            return AnyView(SignInWithGoogleView())
        case .apple:
            return AnyView(SignInWithAppleView())
        case .home:
            return nil
        }
    }
}
