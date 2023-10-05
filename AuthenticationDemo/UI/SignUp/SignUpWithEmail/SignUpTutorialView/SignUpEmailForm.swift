//
//  SignUpEmailForm.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/10/02.
//

import SwiftUI
import RswiftResources

struct SignUpEmailForm: View {
    let presenter: SignUpWithEmailPresenter
    
    @State private var selection: SignUpSelection = .email
    @State private var email = ""
    @State private var password = ""
    @State private var reInputPasword = ""
    
    var body: some View {
        VStack(spacing: 15) {
            SignUpForm(presenter: presenter,
                       type: .email,
                       email: $email,
                       password: $password)
            SignUpForm(presenter: presenter,
                       type: .password,
                       email: $email,
                       password: $password)
            SignUpForm(presenter: presenter,
                       type: .password,
                       email: $email,
                       password: $reInputPasword)
            HeightSpacer(height: 30)
            ContinueButton(selection: selection, presenter: presenter, email: email, password: password, reInputPassword: reInputPasword)
        }
    }
}

private struct SignUpForm: View {
    let presenter: SignUpWithEmailPresenter
    let type: InputFormType
    
    @Binding var email: String
    @Binding var password: String
    
    @State private var isShowingPassword = false
    
    var body: some View {
        CustomizedRoundedRectangle(color: Color.white, content: {
            HStack{
                switch type {
                case .email:
                    Image(systemName: String(resource: R.string.localizable.emailSymbol))
                        .foregroundColor(.gray.opacity(0.5))
                        .frame(width: 10, height: 10)
                    
                    WidthSpacer(width: 20)
                    
                    TextField(String(resource: R.string.localizable.emailTag), text: $email)
                        .font(.system(.body, design: .rounded))
                        .keyboardType(.alphabet)
                        .autocapitalization(.none)
                    
                    Spacer()
                    
                    if presenter.onInputEmail(email: email){
                        Image(systemName: String(resource: R.string.localizable.checkmarkSymbol))
                            .foregroundColor(.green.opacity(0.5))
                            .frame(width: 10, height: 10)
                    } else {
                        Image(systemName: String(resource: R.string.localizable.xmarkSymbol))
                            .foregroundColor(.red.opacity(0.5))
                            .frame(width: 10, height: 10)
                    }
                case .password:
                    Image(systemName: String(resource: R.string.localizable.passwordSymbol))
                        .foregroundColor(.gray.opacity(0.5))
                        .frame(width: 10, height: 10)
                    
                    WidthSpacer(width: 20)
                    
                    PasswordForm(isShowingPassword: isShowingPassword, password: $password)
                    
                    Spacer()
                    
                    Image(systemName: isShowingPassword ? String(resource: R.string.localizable.eyeSlashSymbol) : String(resource: R.string.localizable.eyeSymbol))
                        .resizable()
                        .frame(width: 18, height: 12)
                        .foregroundColor(.gray.opacity(0.5))
                        .onTapGesture{
                            isShowingPassword.toggle()
                        }
                }
            }.padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
        })
    }
}

private struct PasswordForm: View {
    let isShowingPassword: Bool
        
    @Binding var password: String
    
    var body: some View {
        if isShowingPassword {
            TextField(String(resource: R.string.localizable.passwordTag), text: $password)
                .font(.system(.body, design: .rounded))
                .keyboardType(.alphabet)
        } else {
            SecureField(String(resource: R.string.localizable.passwordTag), text: $password)
                .font(.system(.body, design: .rounded))
                .keyboardType(.alphabet)
        }
    }
}

private struct ContinueButton: View {
    let selection: SignUpSelection
    let presenter: SignUpWithEmailPresenter
    let email: String
    let password: String
    let reInputPassword: String
    
    var body: some View {
        Button(action: {
            // ここで単純に次の画面への遷移フラグだけ発火(Viewもらっても意味なし)
//            presenter.onTapContinueButton(selection: selection)
        }, label: {
            if presenter.onInputEmailAndPassword(email: email, password: password, reInputPassword: reInputPassword) {
                CustomizedRoundedRectangle(color: Color.black, content: {
                    Text(R.string.localizable.signInButton)
                        .customizedFont(color: .white)
                })
            } else {
                CustomizedRoundedRectangle(color: Color.white, content: {
                    Text(R.string.localizable.signInButton)
                        .customizedFont(color: .black)
                })
            }
        })
    }
}
