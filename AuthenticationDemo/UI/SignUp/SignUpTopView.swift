//
//  SignUpTopView.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/17.
//

import SwiftUI
import RswiftResources

struct SignUpTopView: View {
    private let GIDinteractor = SignInUpWithGoogleInteractor()
    
    var body: some View {
        VStack(spacing: 15){
            Text(R.string.localizable.signUpTitle)
                .font(.system(.largeTitle, design: .rounded))
                .bold()
            Spacer()
            SignUpWithEmailButton()
            SignUpWithGoogleButton(interactor: GIDinteractor)
            SignUpWithAppleButton()
        }
        .padding(EdgeInsets(top: 120, leading: 0, bottom: 150, trailing: 0))
        .customBackwardButton()
    }
}

struct SignUpTopView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpTopView()
    }
}
