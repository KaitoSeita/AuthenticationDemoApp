//
//  SignInWithAppleButton.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/25.
//

import SwiftUI
import AuthenticationServices

struct SignInWithAppleButton: View {
    @ObservedObject private var presenter = SignInUpWithApplePresenter()
    
    var body: some View {
        AppleSignInButton()
            .grayShadow()
            .frame(width: 330, height: 55)
            .cornerRadius(20)
            .onTapGesture {
                presenter.onTapSignInUpWithAppleButton()
            }
    }
}

private struct AppleSignInButton: UIViewRepresentable {
    typealias UIViewType = ASAuthorizationAppleIDButton

    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton(type: .signIn, style: .black)
    }

    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {}
}
