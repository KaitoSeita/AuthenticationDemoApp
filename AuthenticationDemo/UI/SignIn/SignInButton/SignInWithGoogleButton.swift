//
//  SignInWithGoogleButton.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/25.
//

import SwiftUI

struct SignInWithGoogleButton: View {
    @State private var signInWithGoogleObject: SignInUpWithGooglePresenter = SignInUpWithGooglePresenter()
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: 330, height: 55)
            .foregroundColor(.white)
            .grayShadow()
            .overlay{
                HStack {
                    Image(R.image.gLogo)
                        .resizable()
                        .frame(width: 18, height: 18)
                    Spacer()
                        .frame(width: 24)
                    Text(R.string.localizable.signInWithGoogle)
                        .font(.custom("Robot-Black", size: 18))
                        .foregroundColor(.black)
                        .bold()
                }
            }
            .onTapGesture {
                signInWithGoogleObject.signInWIthGoogle()
            }
    }
}
