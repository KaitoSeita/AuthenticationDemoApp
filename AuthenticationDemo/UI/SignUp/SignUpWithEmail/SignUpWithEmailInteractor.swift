//
//  SignUpWithEmailInteractor.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/10/02.
//

import FirebaseAuth

protocol SignUpWithEmailInteractorProtocol {
    func makeUser(email: String, password: String) async -> Result<User, Error>
}

final class SignUpWithEmailInteractor: SignUpWithEmailInteractorProtocol {
    
    func makeUser(email: String, password: String) async -> Result<User, Error> {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            let userInfo = User(id: result.user.uid,
                                displayName: result.user.displayName ?? "",
                                email: result.user.email ?? "")
            return .success(userInfo)
        } catch {
            return .failure(error)
        }
    }
}
