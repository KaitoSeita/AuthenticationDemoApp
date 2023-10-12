//
//  SuccessView.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/28.
//

import SwiftUI
import RswiftResources
import AlertToast

struct SuccessView: View {
    var body: some View {
        VStack {
            Text(R.string.localizable.successViewTitle)
                .font(.system(.title, design: .rounded))
                .bold()
            Text(R.string.localizable.successViewSubTitle)
                .font(.system(size: 12, design: .rounded))
                .bold()
        }
    }
}

struct SendEmailSuccessView: View {
    @Binding var isShowingAlert: Bool
    
    let presenter: SignInWithEmailPresenter
    let email: String
    
    var body: some View {
        VStack {
            CloseButton()
            HeightSpacer(height: 30)
            Text(R.string.localizable.onTapSendEmailButton)
                .font(.system(.title, design: .rounded))
                .bold()
            HeightSpacer(height: 30)
            Text(R.string.localizable.successSendEmailSubTitle)
                .font(.system(size: 12, design: .rounded))
                .bold()
            HeightSpacer(height: 30)
            ResendEmailButton(isShowingAlert: $isShowingAlert, presenter: presenter, email: email)
            Spacer()
        }
        .padding(EdgeInsets(top: 25, leading: 25, bottom: 0, trailing: 25))
        .alert("Resend an e-mail?", isPresented: $isShowingAlert) {
            Button("キャンセル") { }
            Button("送信") {
                presenter.onTapResendEmailButton(email: email)
            }
        } message: {
            Text("メールを再送信しますか？")
        }
    }
}

private struct ResendEmailButton: View {
    @Binding var isShowingAlert: Bool
    
    let presenter: SignInWithEmailPresenter
    let email: String
    
    var body: some View {
        Button(action: {
            isShowingAlert = true
        }, label: {
            Text(R.string.localizable.reSendEmailButtonTitle)
                .foregroundStyle(.blue)
                .font(.system(size: 12, design: .rounded))
                .bold()
        })
    }
}
