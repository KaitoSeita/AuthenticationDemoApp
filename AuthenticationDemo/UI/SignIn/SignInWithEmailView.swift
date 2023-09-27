//
//  SignInWithEmailPasswordView.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/07.
//

import SwiftUI
import RswiftResources

// FIXME: 入力完了前後でサインインボタンの色を切り替える

struct SignInWithEmailView: View {
    @State private var isShowingErrorMessage = false
    @State private var isShowingSuccessView = false
    @State private var email = ""
    @State private var password = ""
    
    @ObservedObject private var presenter: SignInWithEmailPresenter
    
    private let interactor: SignInWithEmailInteractor
    
    init(interactor: SignInWithEmailInteractor) {
        self.interactor = interactor
        _presenter = ObservedObject(wrappedValue: SignInWithEmailPresenter(interactor: interactor))
    }

    var body: some View {
        // FIXME: トースト的な感じで自動でフラグ変更などを備えたものを別で用意しちゃうというのが一番いい
        
        VStack(spacing: 15) {
            SignInForm(presenter: presenter,
                       type: .email,
                       email: $email,
                       password: $password)
            SignInForm(presenter: presenter,
                       type: .password,
                       email: $email,
                       password: $password)
            HeightSpacer(height: 30)
            SignInButton(presenter: presenter,
                         email: email,
                         password: password)
        }
        .customBackwardButton()
        .navigationDestination(isPresented: $presenter.isShowingSuccessView, destination: {
            SuccessView()
                .navigationBarBackButtonHidden(true)
        })
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
                    }else{
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
                // ローディングアニメーションのフラグ発火
                
            }, label: {
                if presenter.onInputEmailAndPassword(email: email, password: password) {
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
}

