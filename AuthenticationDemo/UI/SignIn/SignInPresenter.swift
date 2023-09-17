//
//  SignInPresenter.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/07.
//

import Foundation
import FirebaseAuth

final class SignInPresenter: ObservableObject {
    @Published var userInfo: UserInfo
    
    init() {
        userInfo = UserInfo(id: "", displayName: "", email: "")
    }
    
    func onTap(email: String, password: String) {
        Task {
            await signInWithEmailAndPassword(email: email, password: password)
        }
    }
    
    private func signInWithEmailAndPassword(email: String, password: String) async {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            userInfo = UserInfo(id: result.user.uid,
                                displayName: result.user.displayName ?? "",
                                email: result.user.email ?? ""
            )
        } catch {
            print("error")
        }
    }

}
