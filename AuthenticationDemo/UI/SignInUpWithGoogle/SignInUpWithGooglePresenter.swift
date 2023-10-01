//
//  SignInUpWithGooglePresenter.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/26.
//

import GoogleSignIn
import FirebaseAuth
import FirebaseCore
import RswiftResources

final class SignInUpWithGooglePresenter: ObservableObject {
    @Published var isShowingSuccessView: Bool
    @Published var isShowingErrorMessage: Bool
    @Published var isShowingLoadingToast: Bool
    @Published var errorMessage: String
    
    private let interactor: SignInUpWithGoogleInteractor
    
    init(interactor: SignInUpWithGoogleInteractor) {
        self.interactor = interactor
        isShowingSuccessView = false
        isShowingErrorMessage = false
        isShowingLoadingToast = false
        errorMessage = ""
    }
}

extension SignInUpWithGooglePresenter {
    
    func onTapSignInWithGoogleButton() {
        let rootViewController = self.interactor.makeButtonUI()
        Task { @MainActor in
            let googleResult = await self.interactor.signInWithGoogle(rootViewController: rootViewController)
            switch googleResult {
            case .success(let user):
                let credential = GoogleAuthProvider.credential(withIDToken: user.idToken ?? "",
                                                               accessToken: user.accessToken ?? "")
                let firebaseResult = await self.interactor.signInWithFirebaseAuth(credential: credential)
                switch firebaseResult {
                case .success(_):
                    self.isShowingSuccessView = true
                    self.isShowingLoadingToast = false
                case .failure(let error):
                    setFirebaseAuthErrorMessage(error: error)
                    self.isShowingErrorMessage = true
                }
            case .failure(_):
                errorMessage = String(resource: R.string.localizable.signInWithGooleErrorMessage)
                self.isShowingErrorMessage = true
                self.isShowingLoadingToast = false
            }
        }
        
    }

    private func setFirebaseAuthErrorMessage(error: Error?) {
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
