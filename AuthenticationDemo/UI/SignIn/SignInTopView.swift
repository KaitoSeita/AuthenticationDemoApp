//
//  SignInTopView.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/17.
//

import SwiftUI

struct SignInTopView: View {
    @StateObject private var presenter: SignInTopPresenter
    
    init() {
        _presenter = StateObject(wrappedValue: SignInTopPresenter())
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 15){
                // FIXME: 表示の文言を変更
                Text(R.string.localizable.appTitle)
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
                Spacer()
                // FIXME: ボタンのUIを規約に基づいたものに変更
                SignInWithEmailButton(presenter: presenter)
                SignInWithGoogleButton(presenter: presenter)
                SignInWithAppleButton()
            }
            .padding(EdgeInsets(top: 120, leading: 0, bottom: 150, trailing: 0))
        }
    }
}
