//
//  SignUpConfirmation.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/10/04.
//

import SwiftUI

struct SignUpConfirmation: View {
    @ObservedObject var presenter: SignUpWithEmailPresenter
    @ObservedObject var user: SignUpUser
    
    @Binding var selection: SignUpSelection
    
    let indicatorPresenter: SignUpWithEmailStepIndicatorPresenter

    var body: some View {
        VStack(spacing: 15) {
            Explanation()
            
            Spacer()
            SignUpButton(user: user, presenter: presenter)
            HeightSpacer(height: 80)
        }
        .onAppear {
            indicatorPresenter.colorSelecter(selection: selection)
        }
        .padding(.top, 70)
        .signUpBackwardButton(selection: $selection)
        .navigationDestination(isPresented: $presenter.isShowingSuccessView, destination: {
            SignUpSuccessView()
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
            Text(R.string.localizable.confirmationTitle)
                .font(.system(.title, design: .rounded))
                .bold()
            Text(R.string.localizable.confirmationSubTitle)
                .font(.system(size: 12, design: .rounded))
                .bold()
            HeightSpacer(height: 20)
            Text(R.string.localizable.confirmationExplanation)
                .font(.system(size: 12, design: .rounded))
                .bold()
        }
    }
}

private struct Confirmation: View {
    @ObservedObject var user: SignUpUser
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                
            }
        }
    }
}

private struct SignUpButton: View {
    @ObservedObject var user: SignUpUser
    
    let presenter: SignUpWithEmailPresenter
    
    var body: some View {
        Button(action: {
            presenter.onTapSignUpButton(email: user.email, password: user.password)
        }, label: {
            CustomizedRoundedRectangle(color: Color.black, content: {
                Text(R.string.localizable.signUpConfirmation)
                    .customizedFont(color: .white)
            })
        })
    }
}
