//
//  SignUpWithEmailRouter.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/17.
//

import SwiftUI

// 各遷移先のViewにおいてEnvironmentObjectでSelectionを持たせておくこと
// 戻るボタン, 入力完了後の進むボタンで毎回呼び出しをかければいい
// Topに戻る際はdismissでNavigationを破壊して戻るとか？

struct SignUpWithEmailRouter {
    
    func setDestination(selection: SignUpSelection, presenter: SignUpWithEmailPresenter) -> AnyView? {
        
        switch selection {
        case .email:
            return AnyView(SignUpEmailForm(presenter: presenter))
        case .userInfomation:
            return AnyView(SignUpUserInfomationForm())
        case .questionnaire:
            return AnyView(SignUpQuestionnaire())
        }
    }
}
