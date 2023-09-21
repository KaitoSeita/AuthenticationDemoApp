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
    @State private var selection: AuthenticationTopSelection = .home
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 15){
                Text(R.string.localizable.appTitle)
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
                Spacer()
                SignInButton()
                SignUpButton()
            }
            .padding(EdgeInsets(top: 120, leading: 0, bottom: 150, trailing: 0))
        }
    }
}

private struct SignInButton: View {
    
    var body: some View {
        NavigationLink {
            AuthenticationTopRouter().setDestination(selection: .signIn)
        } label: {
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
        }
    }
}

private struct SignUpButton: View {

    var body: some View {
        NavigationLink {
            AuthenticationTopRouter().setDestination(selection: .signUp)
        } label: {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 330, height: 60)
                .foregroundColor(.black.opacity(0.85))
                .shadow(color: .white.opacity(0.8), radius: 10, x: -7, y: -7)
                .shadow(color: .gray.opacity(0.3), radius: 10, x: 8, y: 8)
                .overlay{
                    Text(R.string.localizable.signUpButton)
                        .font(.system(size: 20, design: .rounded))
                        .foregroundColor(.white)
                        .bold()
                }
        }
    }
}
