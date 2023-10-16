//
//  SignUpWithEmailPresenter.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/10/02.
//

import SwiftUI
import FirebaseAuth

final class SignUpWithEmailPresenter: ObservableObject {
    @Published var errorMessage: String
    @Published var isShowingSuccessView: Bool
    @Published var isShowingErrorMessage: Bool
    @Published var isShowingLoadingToast: Bool
    
    private let interactor: SignUpWithEmailInteractor
    
    init(interactor: SignUpWithEmailInteractor) {
        errorMessage = ""
        isShowingSuccessView = false
        isShowingErrorMessage = false
        isShowingLoadingToast = false
        self.interactor = interactor
    }
}

extension SignUpWithEmailPresenter {
    
    func onTapSignUpButton(email: String, password: String) {
        isShowingLoadingToast = true
        Task { @MainActor in
            let result = await signUpWithEmailAndPassword(email: email, password: password)
            isShowingLoadingToast = false
            switch result {
            case .success(_):
                isShowingSuccessView = true
            case .failure(let error):
                setErrorMessage(error: error)
                isShowingErrorMessage = true
            }
        }
    }
    
    func onInputEmail(email: String) -> Bool {
        return isValidEmail(email: email)
    }
    
    func onInputEmailAndPassword(email: String, password: String, reInputPassword: String) -> Bool {
        return isValidEmailAndPassword(email: email, password: password, reInputPassword: reInputPassword)
    }
    
    private func signUpWithEmailAndPassword(email: String, password: String) async -> Result<User, Error> {
        return await interactor.makeUser(email: email, password: password)
    }
    
    private func isValidEmailAndPassword(email: String, password: String, reInputPassword: String) -> Bool {
        if isValidEmail(email: email) && password.count >= 6 && password == reInputPassword {
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
