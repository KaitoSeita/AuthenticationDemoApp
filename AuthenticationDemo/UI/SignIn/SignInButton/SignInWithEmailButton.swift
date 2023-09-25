//
//  SignInWithEmailButton.swift
//  AuthenticationDemo
//
//  Created by セイタカイト on 2023/09/25.
//

import SwiftUI

struct SignInWithEmailButton: View {
    let presenter: SignInTopPresenter
    
    var body: some View {
        NavigationLink {
            presenter.onTapSignInWithEmailButton()
        } label: {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 330, height: 60)
                .foregroundColor(.white)
                .shadow(color: .white.opacity(0.8), radius: 10, x: -7, y: -7)
                .shadow(color: .gray.opacity(0.3), radius: 10, x: 8, y: 8)
                .overlay{
                    Text(R.string.localizable.signInWithGoogle)
                        .font(.system(size: 20, design: .rounded))
                        .foregroundColor(.black)
                        .bold()
                }
        }
    }
}
