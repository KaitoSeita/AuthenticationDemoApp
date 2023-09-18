//
//  SignInInteractor.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/18.
//

import Foundation
import FirebaseAuth

protocol SignInWithEmailPasswordInteractor {
    func fetchUserInfo(email: String, password: String) -> Result<UserInfo, Error>
    func resetPassword(email: String)
}

func fetchUserInfo(email: String, password: String) async -> Result<UserInfo, Error> {
    do {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        let userInfo = UserInfo(id: result.user.uid,
                            displayName: result.user.displayName ?? "",
                            email: result.user.email ?? ""
        )
        return .success(userInfo)
    } catch {
        return .failure(error)
    }
}
