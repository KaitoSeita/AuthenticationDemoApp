//
//  SignInInWithEmailteractor.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/18.
//

import Foundation
import FirebaseAuth

protocol SignInWithEmailInteractorProtocol {
    func fetchUserInfo(email: String, password: String) -> Result<User, Error>
    func resetPassword(email: String)
}

final class SignInWithEmailInteractor {
    
    func fetchUserInfo(email: String, password: String) async -> Result<User, Error> {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            let userInfo = User(id: result.user.uid,
                                displayName: result.user.displayName ?? "",
                                email: result.user.email ?? "")
            return .success(userInfo)
        } catch {
            return .failure(error)
        }
    }
}
