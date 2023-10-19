//
//  SignInWithEmailPasswordView.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/07.
//

import SwiftUI
import AlertToast

struct SignInWithEmailView: View {
    @State private var email = "sample@email.com"
    @State private var password = "aaaaaaaa"
        
    @ObservedObject private var presenter: SignInWithEmailPresenter
    
    private let interactor: SignInWithEmailInteractor
    
    init(interactor: SignInWithEmailInteractor) {
        self.interactor = interactor
        _presenter = ObservedObject(wrappedValue: SignInWithEmailPresenter(interactor: interactor))
    }

    var body: some View {
        VStack(spacing: 15) {
            Explanation()
            HeightSpacer(height: 100)
            SignInForm(presenter: presenter,
                       type: .email,
                       email: $email,
                       password: $password)
            SignInForm(presenter: presenter,
                       type: .password,
                       email: $email,
                       password: $password)
            HeightSpacer(height: 30)
            VStack(alignment: .leading, spacing: 20) {
                SignInButton(presenter: presenter,
                             email: email,
                             password: password)
                ResetPasswordButton()
            }
            Spacer()
        }
        .padding(.top, 50)
        .customBackwardButton()
        .navigationDestination(isPresented: $presenter.isShowingSuccessView, destination: {
            SignInSuccessView()
                .navigationBarBackButtonHidden(true)
        })
        .toast(isShowingErrorMessage: $presenter.isShowingErrorMessage,
               isShowingLoadingToast: $presenter.isShowingLoadingToast,
               errorMessage: presenter.errorMessage)
    }
}

private struct Explanation: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text(R.string.localizable.signInWithEmail)
                .font(.system(.title, design: .rounded))
                .bold()
            Text(R.string.localizable.inputEmailAndPassword)
                .font(.system(size: 12, design: .rounded))
                .bold()
            HeightSpacer(height: 20)
            Text(R.string.localizable.inputPasswordExplanation)
                .font(.system(size: 12, design: .rounded))
                .bold()
        }
    }
}

private struct SignInForm: View {
    let presenter: SignInWithEmailPresenter
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

private struct SignInButton: View {
    let presenter: SignInWithEmailPresenter
    let email: String
    let password: String
        
    var body: some View {
        VStack {
            Button(action: {
                presenter.onTapSignInButton(email: email, password: password)
            }, label: {
                if presenter.onInputEmailAndPassword(email: email, password: password) {
                    CustomizedRoundedRectangle(color: Color.black, content: {
                        Text(R.string.localizable.signInButton)
                            .customizedFont(color: .white)
                    })
                } else {
                    CustomizedRoundedRectangle(color: .gray.opacity(0.1), content: {
                        Text(R.string.localizable.signInButton)
                            .customizedFont(color: .black)
                    })
                }
            })
            .disabled(!presenter.onInputEmailAndPassword(email: email, password: password))
        }
    }
}

private struct ResetPasswordButton: View {
    let interactor = SignInWithEmailInteractor()
    
    var body: some View {
        NavigationLink(destination: {
            ResetPasswordView(interactor: interactor)
        }, label: {
            Text(R.string.localizable.resetPasswordButtonTitle)
                .font(.system(size: 12, design: .rounded))
                .bold()
                .padding(10)
        })
    }
}

