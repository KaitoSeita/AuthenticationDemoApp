//
//  SignUpWithEmailStepIndicatorView.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/10/02.
//

import SwiftUI

struct SignUpWithEmailStepIndicatorView: View {
    @ObservedObject var presenter: SignUpWithEmailStepIndicatorPresenter

    var body: some View {
        VStack {
            HeightSpacer(height: 25)
            HStack {
                ForEach(presenter.colorItems){ color in
                    Circle()
                        .frame(width: 15, height: 10)
                        .foregroundColor(color.color.opacity(0.85))
                        .grayShadow()
                }
            }
            Spacer()
        }
    }
}
