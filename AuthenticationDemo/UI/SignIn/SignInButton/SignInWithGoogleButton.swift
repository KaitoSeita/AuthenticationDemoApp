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
            CustomizedRoundedRectangle(color: Color.white, content: {
                HStack {
                    Image(R.image.gLogo)
                        .resizable()
                        .frame(width: 18, height: 18)
                    WidthSpacer(width: 8)
                    Text(R.string.localizable.signInWithGoogle)
                        .customizedFont(color: .black)
                }
            })
            .onTapGesture {
                signInWithGoogleObject.signInWIthGoogle()
            }
    }
}
