//
//  SignInWithGoogleButton.swift
//  AuthenticationDemo
//
//  Created by セイタカイト on 2023/09/25.
//

import SwiftUI

struct SignInWithGoogleButton: View {
    let presenter: SignInTopPresenter
    
    var body: some View {
        NavigationLink {
            presenter.onTapSignInWithGoogleButton()
        } label: {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 330, height: 60)
                .foregroundColor(.white)
                .shadow(color: .white.opacity(0.8), radius: 10, x: -7, y: -7)
                .shadow(color: .gray.opacity(0.3), radius: 10, x: 8, y: 8)
                .overlay{
                    Text(R.string.localizable.signInWithEmail)
                        .font(.system(size: 20, design: .rounded))
                        .foregroundColor(.black)
                        .bold()
                }
        }
    }
}
