//
//  SignUpWithEmailPresenter.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/10/02.
//

// SignUpTopViewからemailに来る時, Navigationの遷移で来る. その際, 戻るボタンは廃止してオリジナルのボタンを配置(そのままのボタンを使用すると一気にTopViewに戻ってしまうため)

import SwiftUI
import FirebaseAuth

final class SignUpWithEmailPresenter: ObservableObject {
    @Published var selection: SignUpSelection
    @Published var errorMessage: String
    @Published var isShowingSuccessView: Bool
    @Published var isShowingErrorMessage: Bool
    @Published var isShowingLoadingToast: Bool
    
    init() {
        errorMessage = ""
        isShowingSuccessView = false
        isShowingErrorMessage = false
        isShowingLoadingToast = false
        selection = .email
    }
}

extension SignUpWithEmailPresenter {
    
    func onTapSignUpButton(email: String, password: String) {
        
    }
    
    func onTapSignUpWithEmailButton(presenter: SignUpWithEmailPresenter) -> AnyView? {
        return SignUpWithEmailRouter().setDestination(selection: .email, presenter: presenter)
    }
    
    func onTapBackWardButton(selection: SignUpSelection, presenter: SignUpWithEmailPresenter) -> AnyView? {
        switch selection {
        case .email:
            // ナビゲーションで戻りたい
            return AnyView(EmptyView())
        case .userInfomation:
            return AnyView(SignUpEmailForm(presenter: presenter))
        case .questionnaire:
            return AnyView(SignUpUserInfomationForm())
        }
    }
    
    func onTapContinueButton(selection: SignUpSelection) -> AnyView? {
        switch selection {
        case .email:
            return AnyView(SignUpUserInfomationForm())
        case .userInfomation:
            return AnyView(SignUpQuestionnaire())
        case .questionnaire:
            // ここは通信処理をして画面遷移をさせるので, なにもしないこと
            return AnyView(EmptyView())
        }
    }
    
    func onInputEmail(email: String) -> Bool {
        return isValidEmail(email: email)
    }
    
    func onInputEmailAndPassword(email: String, password: String, reInputPassword: String) -> Bool {
        return isValidEmailAndPassword(email: email, password: password, reInputPassword: reInputPassword)
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
