//
//  SignInWithGoogleButton.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/25.
//

import SwiftUI
import RswiftResources
import AlertToast

struct SignInWithGoogleButton: View {
    private let interactor: SignInUpWithGoogleInteractor

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
                    Text(R.string.localizable.signInWithGoogle)
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
                    .onAppear {
                        presenter.isShowingLoadingToast = false
                    }
            })
            .toast(isPresenting: $presenter.isShowingErrorMessage, alert: {
                // ErrorToast
                AlertToast(displayMode: .hud ,
                           type: .systemImage(String(resource: R.string.localizable.alertSymbol), .red.opacity(0.5)),
                           subTitle:  presenter.errorMessage)
            })
            .toast(isPresenting: $presenter.isShowingLoadingToast, alert: {
                // LoadingToast
                AlertToast(type: .loading)
            })
    }
}
