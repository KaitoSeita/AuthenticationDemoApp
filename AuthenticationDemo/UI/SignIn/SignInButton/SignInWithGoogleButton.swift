//
//  SignInWithGoogleButton.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/25.
//

import SwiftUI

// FIXME: ボタンの配色など規約に対応したものに変更

struct SignInWithGoogleButton: View {
    let presenter: SignInTopPresenter
    
    var body: some View {
        NavigationLink {
            presenter.onTapSignInWithGoogleButton()
        } label: {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 330, height: 50)
                .foregroundColor(.white)
                .shadow(color: .white.opacity(0.8), radius: 10, x: -7, y: -7)
                .shadow(color: .gray.opacity(0.3), radius: 10, x: 8, y: 8)
                .overlay{
                    Text(R.string.localizable.signInWithGoogle)
                        .font(.system(size: 18, design: .rounded))
                        .foregroundColor(.black)
                        .bold()
                }
        }
    }
}
