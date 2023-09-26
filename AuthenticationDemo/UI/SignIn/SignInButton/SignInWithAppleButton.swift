//
//  SignInWithAppleButton.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/25.
//

import SwiftUI
import AuthenticationServices

// FIXME: ボタンの配色など規約に対応したものに変更
// 基本的には自分でViewを用意して画面遷移させるといった対応は不要

struct SignInWithAppleButton: View {
    var body: some View {
        AppleIDButton()
            .frame(width: 330, height: 50)
            .cornerRadius(20)
    }
}

private struct AppleIDButton: UIViewRepresentable {
    typealias UIViewType = ASAuthorizationAppleIDButton

    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton(type: .signIn, style: .black)
    }

    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {}
}
