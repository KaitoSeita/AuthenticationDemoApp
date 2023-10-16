//
//  SignUpWithEmailButton.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/26.
//

import SwiftUI

struct SignUpWithEmailButton: View {
    private let interactor: SignUpWithEmailInteractor = SignUpWithEmailInteractor()
    
    var body: some View {
        NavigationLink {
            SignUpWithEmailView(interactor: interactor)
        } label: {
            CustomizedRoundedRectangle(color: Color.white, content: {
                HStack {
                    Image(systemName: String(resource: R.string.localizable.emailSymbol))
                        .resizable()
                        .frame(width: 16, height: 12)
                        .foregroundColor(.black)
                    WidthSpacer(width: 12)
                    Text(R.string.localizable.signUpWithEmail)
                        .customizedFont(color: .black)
                }
            })
        }
    }
}
