//
//  SignUpWithAppleButton.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/17.
//

import SwiftUI
import AuthenticationServices

struct SignUpWithAppleButton: UIViewRepresentable {
    typealias UIViewType = ASAuthorizationAppleIDButton

    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton(type: .signUp, style: .black)
    }

    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {}
}
