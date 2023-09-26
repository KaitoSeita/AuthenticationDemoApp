//
//  SignInWithEmailButton.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/25.
//

import SwiftUI

struct SignInWithEmailButton: View {
    private let interactor: SignInWithEmailInteractor = SignInWithEmailInteractor()
    
    var body: some View {
        NavigationLink {
            SignInWithEmailView(interactor: interactor)
        } label: {
            RoundedRectangle(cornerRadius: 20)
                .grayShadow()
                .frame(width: 330, height: 55)
                .foregroundColor(.white)
                .overlay{
                    Text(R.string.localizable.signInWithEmail)
                        .font(.system(size: 18, design: .rounded))
                        .foregroundColor(.black)
                        .bold()
                }
        }
    }
}
