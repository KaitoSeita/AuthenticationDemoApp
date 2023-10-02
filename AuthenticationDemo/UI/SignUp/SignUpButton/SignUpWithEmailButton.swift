//
//  SignUpWithEmailButton.swift
//  AuthenticationDemo
//
//  Created by セイタカイト on 2023/09/26.
//

import SwiftUI

struct SignUpWithEmailButton: View {
    var body: some View {
        NavigationLink {
            SignUpWithEmailView()
        } label: {
            CustomizedRoundedRectangle(color: Color.white, content: {
                HStack {
                    Image(systemName: String(resource: R.string.localizable.emailSymbol))
                        .resizable()
                        .frame(width: 16, height: 12)
                        .foregroundColor(.black)
                    WidthSpacer(width: 12)
                    Text(R.string.localizable.signUpWithEmail)
                        .customizedFont(color: .black)
                }
            })
        }
    }
}

struct SignUpWithEmailButton_Previews: PreviewProvider {
    static var previews: some View {
        SignUpWithEmailButton()
    }
}
