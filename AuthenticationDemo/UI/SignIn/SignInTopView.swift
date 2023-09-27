//
//  SignInTopView.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/17.
//

import SwiftUI

struct SignInTopView: View {
    
    var body: some View {
        VStack(spacing: 15){
            Text(R.string.localizable.signInTitle)
                .font(.system(.largeTitle, design: .rounded))
                .bold()
            Spacer()
            SignInWithEmailButton()
            SignInWithGoogleButton()
            SignInWithAppleButton()
        }
        .padding(EdgeInsets(top: 120, leading: 0, bottom: 150, trailing: 0))
        .customBackwardButton()
    }
}
