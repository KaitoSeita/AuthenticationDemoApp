//
//  SignInTopRouter.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/17.
//

import Foundation
import SwiftUI

// SignInTopPresenterから受けた画面遷移の依頼に従ってViewを返す

struct SignInTopRouter {
    private let interactor: SignInWithEmailInteractor = SignInWithEmailInteractor()
    
    func setDestination(selection: SignInTopSelection) -> AnyView? {
        
        switch selection {
        case .email:
            return AnyView(SignInWithEmailView(interactor: interactor))
        case .google:
            return AnyView(EmptyView())
        case .apple:
            return AnyView(EmptyView())
        }
    }
}
