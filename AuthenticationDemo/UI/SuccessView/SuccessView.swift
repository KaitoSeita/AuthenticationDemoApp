//
//  SuccessView.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/28.
//

import SwiftUI
import RswiftResources

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
    
    var body: some View {
        VStack {
            CloseButton()
            HeightSpacer(height: 50)
            Text(R.string.localizable.onTapSendEmailButton)
                .font(.system(.title, design: .rounded))
                .bold()
            HeightSpacer(height: 30)
            Text(R.string.localizable.successSendEmailSubTitle)
                .font(.system(size: 12, design: .rounded))
                .bold()
            HeightSpacer(height: 30)
            Text(R.string.localizable.reSendEmailButtonTitle)
                .font(.system(size: 12, design: .rounded))
                .bold()
            Spacer()
        }.padding(EdgeInsets(top: 25, leading: 25, bottom: 0, trailing: 25))
    }
}
