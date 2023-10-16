//
//  SignUpWithEmailView.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/10/04.
//

import SwiftUI

// MARK: EnvironmentObjectを使用するとSwitch文で再描画を繰り返してしまって値の保持ができないのでStateObjectで管理

struct SignUpWithEmailView: View {
    @ObservedObject private var presenter: SignUpWithEmailPresenter
    @ObservedObject private var indicatorPresenter: SignUpWithEmailStepIndicatorPresenter
    
    @StateObject var user: SignUpUser = SignUpUser()
    
    @State private var selection: SignUpSelection = .email
    
    let interactor: SignUpWithEmailInteractor

    init(interactor: SignUpWithEmailInteractor) {
        self.interactor = interactor
        _presenter = ObservedObject(wrappedValue: SignUpWithEmailPresenter(interactor: interactor))
        _indicatorPresenter = ObservedObject(wrappedValue: SignUpWithEmailStepIndicatorPresenter())
    }
    
    var body: some View {
        ZStack {
            SignUpWithEmailStepIndicatorView(presenter: indicatorPresenter)
            
            switch selection {
            case .email:
                SignUpEmailForm(presenter: presenter, indicatorPresenter: indicatorPresenter, selection: $selection, user: user)
            case .userInfomation:
                SignUpUserInfomationForm(indicatorPresenter: indicatorPresenter, selection: $selection, user: user)
            case .questionnaire:
                SignUpQuestionnaire(presenter: presenter, indicatorPresenter: indicatorPresenter, selection: $selection, user: user)
            }
        }
    }
}
