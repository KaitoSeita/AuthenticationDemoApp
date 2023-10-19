//
//  SignInWithEmailButton.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/25.
//

import SwiftUI

struct SignInWithEmailButton: View {
    private let interactor: SignInWithEmailInteractor = SignInWithEmailInteractor()
    
    var body: some View {
        NavigationLink {
            SignInWithEmailView(interactor: interactor)
        } label: {
            CustomizedRoundedRectangle(color: Color.white, content: {
                HStack {
                    Image(systemName: String(resource: R.string.localizable.emailSymbol))
                        .resizable()
                        .frame(width: 16, height: 12)
                        .foregroundColor(.black)
                    WidthSpacer(width: 12)
                    Text(R.string.localizable.signInWithEmail)
                        .customizedFont(color: .black)
                }
            })
        }
    }
}
