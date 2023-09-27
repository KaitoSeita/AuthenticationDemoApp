//
//  SignInUpWithGooglePresenter.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/26.
//

import GoogleSignIn
import FirebaseAuth
import FirebaseCore

final class SignInUpWithGooglePresenter {
    
    func signInWIthGoogle() {
        guard let clientID: String = FirebaseApp.app()?.options.clientID else { return }
        let config: GIDConfiguration = GIDConfiguration(clientID: clientID)
        
        let windowScene: UIWindowScene? = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let rootViewController: UIViewController? = windowScene?.windows.first!.rootViewController!
        
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController!) { result, error in
            guard error == nil else {
                print("GID SignIn Error: \(error!.localizedDescription)")
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    print("Firebase SignIn Error: \(error.localizedDescription)")
                    return
                }
            }
        }
    }
}
