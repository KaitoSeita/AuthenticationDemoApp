//
//  SignUpWithAppleButton.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/17.
//

import SwiftUI
import AuthenticationServices

struct SignUpWithAppleButton: View {
    @ObservedObject private var presenter = SignInUpWithApplePresenter()

    var body: some View {
        AppleSignUpButton()
            .grayShadow()
            .frame(width: 330, height: 55)
            .cornerRadius(20)
            .onTapGesture {
                presenter.onTapSignInUpWithAppleButton()
            }
    }
}

struct AppleSignUpButton: UIViewRepresentable {
    typealias UIViewType = ASAuthorizationAppleIDButton

    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton(type: .signUp, style: .black)
    }

    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {}
}
