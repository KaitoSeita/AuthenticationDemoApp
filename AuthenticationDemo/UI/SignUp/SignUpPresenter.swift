//
//  SignUpPresenter.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/07.
//

import Foundation
import FirebaseAuth

final class SignUpPresenter: ObservableObject {
    @Published var userInfo: UserInfo
    @Published var errorMessage: String
    
    init() {
        userInfo = UserInfo(id: "", displayName: "", email: "")
        errorMessage = ""
    }
    
    func onTap(email: String, password: String) {
        Task {
            await signUpWithEmailAndPassword(email: email, password: password)
        }
    }
    
    private func signUpWithEmailAndPassword(email: String, password: String) async {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            userInfo = UserInfo(id: result.user.uid,
                                displayName: result.user.displayName ?? "",
                                email: result.user.email ?? ""
            )
        } catch {
            setErrorMessage(error: error)
        }
    }
    
    // MARK: asyncである必要はない
    private func setErrorMessage(error: Error?) {
        if let error = error as NSError? {
            if let errorCode = AuthErrorCode.Code(rawValue: error.code) {
                switch errorCode {
                case .invalidEmail:
                    errorMessage = R.string.localizable.invalidEmail()
                case .emailAlreadyInUse:
                    errorMessage = R.string.localizable.emailAlreadyInUse()
                case .weakPassword:
                    errorMessage = R.string.localizable.weakPassword()
                case .userNotFound, .wrongPassword:
                    errorMessage = R.string.localizable.userNotFoundOrWrongPassword()
                case .userDisabled:
                    errorMessage = R.string.localizable.userDisabled()
                default:
                    errorMessage = R.string.localizable.default()
                }
            }
        }
    }
}
