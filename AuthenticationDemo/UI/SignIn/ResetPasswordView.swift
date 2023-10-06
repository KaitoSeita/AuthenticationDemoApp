//
//  ResetPasswordView.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/10/02.
//

import SwiftUI

struct ResetPasswordView: View {
    let presenter: SignInWithEmailPresenter
    
    @State private var email = ""
    
    var body: some View {
        VStack {
            Explanation()
            HeightSpacer(height: 100)
            EmailForm(presenter: presenter, email: $email)
            HeightSpacer(height: 30)
            SendButton(presenter: presenter, email: email)
            Spacer()
        }
        .padding(.top, 50)
        .customBackwardButton()
    }
}

private struct Explanation: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text(R.string.localizable.resetPasswordTitle)
                .font(.system(.title, design: .rounded))
                .bold()
            Text(R.string.localizable.resetPasswordSubTitle)
                .font(.system(size: 12, design: .rounded))
                .bold()
            HeightSpacer(height: 20)
            Text(R.string.localizable.resetPasswordExplanation)
                .font(.system(size: 12, design: .rounded))
                .bold()
        }
    }
}

private struct EmailForm: View {
    let presenter: SignInWithEmailPresenter
    
    @Binding var email: String
        
    var body: some View {
        CustomizedRoundedRectangle(color: Color.white, content: {
            HStack{
                Image(systemName: String(resource: R.string.localizable.emailSymbol))
                    .foregroundColor(.gray.opacity(0.5))
                    .frame(width: 10, height: 10)
                
                WidthSpacer(width: 20)
                
                TextField(String(resource: R.string.localizable.emailTag), text: $email)
                    .font(.system(.body, design: .rounded))
                    .keyboardType(.alphabet)
                    .autocapitalization(.none)
                
                Spacer()
            }.padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
        })
    }
}

private struct SendButton: View {
    let presenter: SignInWithEmailPresenter
    let email: String
    
    var body: some View {
        NavigationLink(destination: {
            
        }, label: {
            if !presenter.onInputEmail(email: email) {
                CustomizedRoundedRectangle(color: .gray.opacity(0.1), content: {
                    Text(R.string.localizable.resetPasswordSendingEmail)
                        .customizedFont(color: .black)
                })
            } else {
                CustomizedRoundedRectangle(color: .black, content: {
                    Text(R.string.localizable.resetPasswordSendingEmail)
                        .customizedFont(color: .white)
                })
            }
        })
        .disabled(!presenter.onInputEmail(email: email))
    }
}

private struct SendEmailSuccessView: View {
    var body: some View {
        Text("")
    }
}
