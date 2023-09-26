//
//  SignInWithEmailPasswordView.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/07.
//

import SwiftUI
import RswiftResources

// TODO: 入力フォームのUI作成

struct SignInWithEmailView: View {
    @State private var isShowingErrorMessage = false
    @State private var isShowingSuccessView = false
    @State private var email = ""
    @State private var password = ""
    
    @StateObject private var presenter: SignInWithEmailPresenter
    
    private let interactor: SignInWithEmailInteractor
    
    init(interactor: SignInWithEmailInteractor) {
        self.interactor = interactor
        _presenter = StateObject(wrappedValue: SignInWithEmailPresenter(interactor: interactor))
    }

    var body: some View {
        // FIXME: トースト的な感じで自動でフラグ変更などを備えたものを別で用意しちゃうというのが一番いい
        VStack(spacing: 15) {
            if !presenter.isShowingSuccessView {

                SignInButton(presenter: presenter, email: email, password: password)
            } else {
                EmptyView()
            }
        }
    }
}

private struct SignInForm: View {
    @Binding var email: String
    @Binding var password: String
    
    var body: some View {
        VStack{
            Form {
                
            }
        }
    }
}

private struct SignInButton: View {
    let presenter: SignInWithEmailPresenter
    let email: String
    let password: String
    
    var body: some View {
        Button(action: {
            presenter.onTapSignInButton(email: email, password: password)
        }, label: {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 330, height: 60)
                .foregroundColor(.white)
                .shadow(color: .white.opacity(0.8), radius: 10, x: -7, y: -7)
                .shadow(color: .gray.opacity(0.3), radius: 10, x: 8, y: 8)
                .overlay{
                    Text(R.string.localizable.signInButton)
                        .font(.system(size: 20, design: .rounded))
                        .foregroundColor(.black)
                        .bold()
                }
        })
    }
}

