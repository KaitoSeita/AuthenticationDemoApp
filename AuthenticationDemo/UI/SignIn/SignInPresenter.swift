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
    @Published var errorMessage: String
    
    init() {
        userInfo = UserInfo(id: "", displayName: "", email: "")
        errorMessage = ""
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
    
    private func resetPassWord(email: String) async {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
        } catch {
            print("error")
        }
    }
    
    private func setErrorMessage(error: Error?) async {
        if let error = error as NSError? {
            if let errorCode = AuthErrorCode.Code(rawValue: error.code) {
                switch errorCode {
                case .invalidEmail:
                    errorMessage = "メールアドレスの形式が違います"
                case .emailAlreadyInUse:
                    errorMessage = "このメールアドレスはすでに使われています"
                case .weakPassword:
                    errorMessage = "パスワードが弱すぎます"
                case .userNotFound, .wrongPassword:
                    errorMessage = "メールアドレス、またはパスワードが間違っています"
                case .userDisabled:
                    errorMessage = "このユーザーアカウントは無効化されています"
                default:
                    errorMessage = "予期せぬエラーが発生しました\nしばらく時間を置いてから再度お試しください"
                }
            }
        }
    }
}
