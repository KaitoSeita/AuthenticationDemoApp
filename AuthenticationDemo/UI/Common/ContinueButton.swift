//
//  ContinueButton.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/10/11.
//

import SwiftUI

struct ContinueButton: View {
    @Binding var selection: SignUpSelection
    
    let presenter: SignUpWithEmailPresenter
    let email: String
    let password: String
    let reInputPassword: String
    
    var body: some View {
        Button(action: {
            withAnimation(.linear) {
                switch selection {
                case .email:
                    selection = .userInfomation
                case .userInfomation:
                    selection = .questionnaire
                case .questionnaire:
                    selection = .questionnaire
                }
            }
        }, label: {
            if presenter.onInputEmailAndPassword(email: email, password: password, reInputPassword: reInputPassword) {
                CustomizedRoundedRectangle(color: Color.black, content: {
                    Text(R.string.localizable.continue)
                        .customizedFont(color: .white)
                })
            } else {
                CustomizedRoundedRectangle(color: .gray.opacity(0.1), content: {
                    Text(R.string.localizable.continue)
                        .customizedFont(color: .black)
                })
            }
        })
        .disabled(!presenter.onInputEmailAndPassword(email: email, password: password, reInputPassword: reInputPassword))
    }
}
