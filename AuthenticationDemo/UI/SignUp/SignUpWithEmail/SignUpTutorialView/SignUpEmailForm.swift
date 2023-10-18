//
//  SignUpEmailForm.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/10/02.
//

import SwiftUI
import RswiftResources

struct SignUpEmailForm: View {
    @ObservedObject var user: SignUpUser
    
    @Binding var selection: SignUpSelection
    
    @State private var reInputPasword = "aaaaaaa"
    
    let presenter: SignUpWithEmailPresenter
    let indicatorPresenter: SignUpWithEmailStepIndicatorPresenter
        
    var body: some View {
        VStack(spacing: 15) {
            Explanation()
            HeightSpacer(height: 100)
            SignUpForm(presenter: presenter,
                       type: .email,
                       email: $user.email,
                       password: $user.password)
            HeightSpacer(height: 15)
            SignUpForm(presenter: presenter,
                       type: .password,
                       email: $user.email,
                       password: $user.password)
            SignUpForm(presenter: presenter,
                       type: .password,
                       email: $user.email,
                       password: $reInputPasword)
            Spacer()
            ContinueButton(selection: $selection, presenter: presenter, email: user.email, password: user.password, reInputPassword: reInputPasword)
            HeightSpacer(height: 80)
        }
        .padding(.top, 70)
        .customBackwardButton()
        .onAppear {
            indicatorPresenter.colorSelecter(selection: selection)
        }
    }
}

private struct Explanation: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text(R.string.localizable.signUpWithEmail)
                .font(.system(.title, design: .rounded))
                .bold()
            Text(R.string.localizable.inputEmailAndPassword)
                .font(.system(size: 12, design: .rounded))
                .bold()
            HeightSpacer(height: 20)
            Text(R.string.localizable.makePasswordExplanation)
                .font(.system(size: 12, design: .rounded))
                .bold()
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
            }.padding(.horizontal, 25)
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
    @Binding var selection: SignUpSelection
    
    let presenter: SignUpWithEmailPresenter
    let email: String
    let password: String
    let reInputPassword: String
    
    var body: some View {
        Button(action: {
            withAnimation(.linear) {
                selection = .userInfomation                
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
