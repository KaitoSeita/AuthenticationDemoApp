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
    @Published var userInfo: User
    @Published var errorMessage: String
    @Published var isShowingSuccessView: Bool
    @Published var isShowingErrorMessage: Bool
    
    private let interactor: SignInWithEmailInteractor
    
    init(interactor: SignInWithEmailInteractor) {
        userInfo = User(id: "", displayName: "", email: "")
        errorMessage = ""
        isShowingSuccessView = false
        isShowingErrorMessage = false
        self.interactor = interactor
    }
    
    // エラー内容をViewで表示させるためにメインスレッドで処理をさせる
    func onTapSignInButton(email: String, password: String) {
        Task { @MainActor in
            let result = await signInWithEmailPassword(email: email, password: password)
            switch result {
            case .success(let userInfo):
                self.userInfo = userInfo
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
    
    // FIXME: interactorから受け取ったresultをクロージャ形式で記述したい、、、
    private func signInWithEmailPassword(email: String, password: String) async -> Result<User, Error>{
        return await interactor.fetchUserInfo(email: email, password: password)
    }
    
    // エラーに関してはviewの方でonChangeのエラーメッセージ監視
    // サインイン成功に関してもviewの方でFirebaseの方からCurrentUserで確認するか, userInfoのonChangeかといった感じ
    
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
