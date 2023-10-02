//
//  SignInUpWithGoogleInteractor.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/28.
//

import FirebaseCore
import GoogleSignIn
import FirebaseAuth

// FIXME: すべてPresenterでの記述に変更

protocol SignInUpWithGoogleIntaractorProtocol {
    func signInGoogle() async -> Result<GIDUser, Error>
    func signInFirebaseAuth(credential: AuthCredential) async -> Result<User, Error>
}

final class SignInUpWithGoogleInteractor {
    
    func makeButtonUI() -> UIViewController? {
        let clientID: String = FirebaseApp.app()?.options.clientID ?? ""
        let config: GIDConfiguration = GIDConfiguration(clientID: clientID)
        let windowScene: UIWindowScene? = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let rootViewController: UIViewController? = windowScene?.windows.first!.rootViewController!
        
        GIDSignIn.sharedInstance.configuration = config
        
        return rootViewController
    }
    
    func signInWithFirebaseAuth(credential: AuthCredential) async -> Result<User, Error> {
        do {
            let result = try await Auth.auth().signIn(with: credential)
            let userInfo = User(id: result.user.uid,
                                displayName: result.user.displayName ?? "",
                                email: result.user.email ?? "")
            return .success(userInfo)
        } catch {
            return .failure(error)
        }
    }
    
    func signInWithGoogle(rootViewController: UIViewController?) async -> Result<GIDUser, Error> {
        do {
            let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController!)
            let userInfo = GIDUser(id: result.user.userID,
                                   idToken: result.user.idToken?.tokenString,
                                   accessToken: result.user.accessToken.tokenString)
            return .success(userInfo)
        } catch {
            return .failure(error)
        }
    }
}
