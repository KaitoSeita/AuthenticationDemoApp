//
//  SignInPresenter.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/07.
//

import Foundation
import FirebaseAuth

final class SignInWithEmailPasswordPresenter: ObservableObject {
    @Published var userInfo: UserInfo
    @Published var errorMessage: String
    
    private let interactor: SignInWithEmailPasswordInteractor
    
    init(interactor: SignInWithEmailPasswordInteractor) {
        userInfo = UserInfo(id: "", displayName: "", email: "")
        errorMessage = ""
        self.interactor = interactor
    }
    
    func onTapSignInWithEmailPasswordButton(email: String, password: String) {
        Task {
            await signInWithEmailPassword(email: email, password: password)
        }
    }
    
    func onTapResetPasswordButton(email: String) {
        Task {
            await resetPassWord(email: email)
        }
    }
    
    // FIXME: interactorから受け取ったresultをクロージャ形式で記述したい、、、
    private func signInWithEmailPassword(email: String, password: String) async {
        let result = interactor.fetchUserInfo(email: email, password: password)
        
        switch result {
        case .success(let userInfo):
            self.userInfo = userInfo
        case .failure(let error):
            setErrorMessage(error: error)
        }
    }
    
    private func resetPassWord(email: String) async {
        interactor.resetPassword(email: email)
    }
    
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
