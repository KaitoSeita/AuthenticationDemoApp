//
//  SignInWithGoogleButton.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/25.
//

import SwiftUI

// FIXME: ボタンの配色など規約に対応したものに変更

struct SignInWithGoogleButton: View {    
    var body: some View {
        NavigationLink {

        } label: {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 330, height: 55)
                .foregroundColor(.white)
                .grayShadow()
                .overlay{
                    Text(R.string.localizable.signInWithGoogle)
                        .font(.system(size: 18, design: .rounded))
                        .foregroundColor(.black)
                        .bold()
                }
        }
    }
}
