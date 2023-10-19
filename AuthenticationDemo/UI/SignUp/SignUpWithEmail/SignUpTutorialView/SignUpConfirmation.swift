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
            HeightSpacer(height: 30)
            Confirmation(user: user)
            Spacer()
            SignUpButton(user: user, presenter: presenter)
            HeightSpacer(height: 80)
        }
        .onAppear {
            indicatorPresenter.colorSelecter(selection: selection)
        }
        .padding(.top, 70)
        .signUpBackwardButton(selection: $selection, presenter: presenter)
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
    
    let formatter = DateFormatter()
    
    init(user: SignUpUser) {
        self.user = user
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateStyle = .long
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            // Email
            HStack {
                Image(systemName: String(resource: R.string.localizable.emailSymbol))
                    .resizable()
                    .foregroundColor(.gray.opacity(0.5))
                    .frame(width: 25, height: 17.5)
                
                WidthSpacer(width: 20)
                
                Text(user.email)
                    .frame(maxWidth: 300)
                    .font(.headline)
                    .fontWeight(.heavy)
            }
            // username
            HStack{
                Image(systemName: String(resource: R.string.localizable.userSymbol))
                    .resizable()
                    .foregroundColor(.gray.opacity(0.5))
                    .frame(width: 25, height: 25)
                
                WidthSpacer(width: 20)
                
                Text(user.userName)
                    .frame(maxWidth: 300)
                    .font(.headline)
                    .fontWeight(.heavy)
            }
            // Birthday
            HStack {
                Image(systemName: String(resource: R.string.localizable.calendarSymbol))
                    .resizable()
                    .foregroundColor(.gray.opacity(0.5))
                    .frame(width: 25, height: 25)
                
                WidthSpacer(width: 20)
                
                Text(formatter.string(from: user.birthdayDate))
                    .frame(maxWidth: 300)
                    .font(.headline)
                    .fontWeight(.heavy)
                Spacer()
            }
        }.padding(.horizontal, 50)
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
