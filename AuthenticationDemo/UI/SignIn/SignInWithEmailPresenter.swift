//
//  SignInWithEmailPresenter.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/07.
//

// メインスレッド

import Foundation
import SwiftUI
import FirebaseAuth

final class SignInWithEmailPresenter: ObservableObject {
    @Published var errorMessage: String
    @Published var isShowingSuccessView: Bool
    @Published var isShowingErrorMessage: Bool
    
    private let interactor: SignInWithEmailInteractor
    
    init(interactor: SignInWithEmailInteractor) {
        errorMessage = ""
        isShowingSuccessView = false
        isShowingErrorMessage = false
        self.interactor = interactor
    }
}

// MARK: SignInWithEmailPresenterのメソッド
extension SignInWithEmailPresenter {
    // エラー内容をViewで表示させるためにメインスレッドで処理をさせる
    func onTapSignInButton(email: String, password: String) {
        Task { @MainActor in
            let result = await signInWithEmailPassword(email: email, password: password)
            switch result {
            case .success(_):
                isShowingSuccessView = true
            case .failure(let error):
                setErrorMessage(error: error)
                isShowingErrorMessage = true
            }
        }
    }
    
    func onTapResetPasswordButton(email: String) {
        Task {
            await resetPassWord(email: email)
        }
    }
    
    func onInputEmail(email: String) -> Bool {
        return isValidEmail(email: email)
    }
    
    func onInputEmailAndPassword(email: String, password: String) -> Bool {
        return isValidEmailAndPassword(email: email, password: password)
    }
    
    private func isValidEmailAndPassword(email: String, password: String) -> Bool {
        if isValidEmail(email: email) && password.count >= 6 {
            return true
        } else {
            return false
        }
    }
    
    private func isValidEmail(email: String) -> Bool {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailCheck = NSPredicate(format:"SELF MATCHES %@", pattern)
        return emailCheck.evaluate(with: email)
    }
        
    private func signInWithEmailPassword(email: String, password: String) async -> Result<User, Error>{
        return await interactor.fetchUserInfo(email: email, password: password)
    }
    
    private func resetPassWord(email: String) async {
//        interactor.resetPassword(email: email)
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
