//
//  SignUpWithEmailView.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/10/04.
//

import SwiftUI

struct SignUpWithEmailView: View {
    @StateObject private var presenter: SignUpWithEmailPresenter
    @ObservedObject private var indicatorPresenter: SignUpWithEmailStepIndicatorPresenter
    
    @State private var selection: SignUpSelection = .email

    init() {
        _presenter = StateObject(wrappedValue: SignUpWithEmailPresenter())
        _indicatorPresenter = ObservedObject(wrappedValue: SignUpWithEmailStepIndicatorPresenter())
    }
    
    var body: some View {
        ZStack {
            SignUpWithEmailStepIndicatorView(presenter: indicatorPresenter)
            
            switch selection {
            case .email:
                SignUpEmailForm(presenter: presenter, indicatorPresenter: indicatorPresenter, selection: $selection)
            case .userInfomation:
                SignUpUserInfomationForm(indicatorPresenter: indicatorPresenter, selection: $selection)
            case .questionnaire:
                SignUpQuestionnaire(indicatorPresenter: indicatorPresenter, selection: $selection)
            }

        }
    }
}
