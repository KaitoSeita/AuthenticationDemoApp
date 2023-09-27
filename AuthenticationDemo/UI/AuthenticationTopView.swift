//
//  AuthenticationTopView.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/06.
//

import SwiftUI
import RswiftResources

// MARK: Default View
struct AuthenticationTopView: View {
    @StateObject private var presenter: AuthenticationTopPresenter
    
    init() {
        _presenter = StateObject(wrappedValue: AuthenticationTopPresenter())
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 15){
                Text(R.string.localizable.appTitle)
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
                Spacer()
                SignInButton(presenter: presenter)
                SignUpButton(presenter: presenter)
            }
            .padding(EdgeInsets(top: 120, leading: 0, bottom: 150, trailing: 0))
        }
        .accentColor(.black)
    }
}

private struct SignInButton: View {
    let presenter: AuthenticationTopPresenter
    
    var body: some View {
        NavigationLink {
            presenter.onTapSignInButton()
        } label: {
            RoundedRectangle(cornerRadius: 20)
                .grayShadow()
                .frame(width: 330, height: 55)
                .foregroundColor(.white)
                .overlay{
                    Text(R.string.localizable.signInButton)
                        .font(.system(size: 20, design: .rounded))
                        .foregroundColor(.black)
                        .bold()
                }
        }
    }
}

private struct SignUpButton: View {
    let presenter: AuthenticationTopPresenter

    var body: some View {
        NavigationLink {
            presenter.onTapSignUpButton()
        } label: {
            RoundedRectangle(cornerRadius: 20)
                .grayShadow()
                .frame(width: 330, height: 55)
                .foregroundColor(.black)
                .overlay{
                    Text(R.string.localizable.signUpButton)
                        .font(.system(size: 20, design: .rounded))
                        .foregroundColor(.white)
                        .bold()
                }
        }
    }
}
