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
            CustomizedRoundedRectangle(color: Color.white, content: {
                Text(R.string.localizable.signInButton)
                    .customizedFont(color: .black)
            })
        }
    }
}

private struct SignUpButton: View {
    let presenter: AuthenticationTopPresenter

    var body: some View {
        NavigationLink {
            presenter.onTapSignUpButton()
        } label: {
            CustomizedRoundedRectangle(color: Color.black, content: {
                Text(R.string.localizable.signUpButton)
                    .customizedFont(color: .white)
            })
        }
    }
}
