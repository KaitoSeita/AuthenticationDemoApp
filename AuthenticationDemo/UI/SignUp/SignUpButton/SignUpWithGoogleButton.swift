//
//  SignUpWithGoogleButton.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/28.
//

import SwiftUI

struct SignUpWithGoogleButton: View {
    let interactor: SignInUpWithGoogleInteractor

    @ObservedObject private var presenter: SignInUpWithGooglePresenter
    
    init(interactor: SignInUpWithGoogleInteractor) {
        self.interactor = interactor
        _presenter = ObservedObject(wrappedValue: SignInUpWithGooglePresenter(interactor: interactor))
    }
    
    var body: some View {
            CustomizedRoundedRectangle(color: Color.white, content: {
                HStack {
                    Image(R.image.gLogo)
                        .resizable()
                        .frame(width: 18, height: 18)
                    WidthSpacer(width: 8)
                    Text(R.string.localizable.signUpWithGoogle)
                        .customizedFont(color: .black)
                }
            })
            .onTapGesture {
                presenter.onTapSignInWithGoogleButton()
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $presenter.isShowingSuccessView, destination: {
                SuccessView()
                    .navigationBarBackButtonHidden(true)
            })
    }
}
