//
//  AuthenticationTopRouter.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/06.
//

import Foundation
import SwiftUI

// FIXME: selectionに対してsignInとsignUpが各2回ずつ格納される
struct AuthenticationTopRouter {
    
    func setDestination(selection: AuthenticationTopSelection) -> AnyView? {
        
        switch selection {
        case .signIn:
            return AnyView(SignInTopView())
        case .signUp:
            return AnyView(SignUpTopView())
        case .home:
            return nil
        }
    }
}
