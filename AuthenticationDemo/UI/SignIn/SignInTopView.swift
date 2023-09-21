//
//  SignInTopView.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/17.
//

import SwiftUI

struct SignInTopView: View {
    @State private var selection: SignInTopSelection = .home

    var body: some View {
        NavigationStack {
            VStack(spacing: 15){
                Text(R.string.localizable.appTitle)
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
                Spacer()
                SignInWithEmailButton()
            }
            .padding(EdgeInsets(top: 120, leading: 0, bottom: 150, trailing: 0))
        }
    }
}

private struct SignInWithEmailButton: View {
    
    var body: some View {
        NavigationLink {
            SignInTopRouter().setDestination(selection: .email)
        } label: {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 330, height: 60)
                .foregroundColor(.white)
                .shadow(color: .white.opacity(0.8), radius: 10, x: -7, y: -7)
                .shadow(color: .gray.opacity(0.3), radius: 10, x: 8, y: 8)
                .overlay{
                    Text(R.string.localizable.signInWithEmail)
                        .font(.system(size: 20, design: .rounded))
                        .foregroundColor(.black)
                        .bold()
                }
        }
    }
}

private struct SignInWithGoogleButton: View {
    
    var body: some View {
        VStack {
            
        }
    }
}

private struct SignInWithAppleButton: View {
    
    var body: some View {
        VStack {
            
        }
    }
}

struct SignInTopView_Previews: PreviewProvider {
    static var previews: some View {
        SignInTopView()
    }
}
