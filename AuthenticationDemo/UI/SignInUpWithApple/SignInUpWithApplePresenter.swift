//
//  SignInWithApplePresenter.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/21.
//

import AuthenticationServices
import CryptoKit
import FirebaseAuth
import RswiftResources

final class SignInUpWithApplePresenter: NSObject, ObservableObject {
    @Published var isShowingSuccessView = false
    @Published var isShowingErrorMessage = false
    @Published var isShowingLoadingToast = false
    @Published var errorMessage = ""
    
    private var currentNonce: String?
    private var result: Result<User, Error>?

    func onTapSignInUpWithAppleButton() {
        signInUpWithApple()
        switch result {
        case .success(_):
            self.isShowingSuccessView = true
            self.isShowingLoadingToast = false
        case .failure(let error):
            setFirebaseAuthErrorMessage(error: error)
            self.isShowingErrorMessage = true
        case .none:
            break
        }
    }
    
    public func signInUpWithApple() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.email, .fullName]
        let nonce = randomNonceString()
        currentNonce = nonce
        request.nonce = sha256(nonce)

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }

    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length

        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }

            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }

                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }

        return result
    }

    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()

        return hashString
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

extension SignInUpWithApplePresenter: ASAuthorizationControllerDelegate {

    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {

        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                print("Invalid state: A login callback was received, but no login request was sent.")
                return
            }

            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }

            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data")
                return
            }

            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            
            func signInWithFirebase() async {
                do {
                    let result = try await Auth.auth().signIn(with: credential)
                    let userInfo = User(id: result.user.uid,
                                        displayName: result.user.displayName,
                                        email: result.user.email)
                    self.result = .success(userInfo)
                } catch {
                    self.result = .failure(error)
                }
            }
        }
    }
}
