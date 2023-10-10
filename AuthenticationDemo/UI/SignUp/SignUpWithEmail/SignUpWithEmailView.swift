//
//  SignUpWithEmailView.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/10/04.
//

import SwiftUI

struct SignUpWithEmailView: View {
    @StateObject private var presenter: SignUpWithEmailPresenter
    
    // 画面遷移でアニメーションを適用したいためRouterは使用せずViewに直接記述
    @State private var selection: SignUpSelection = .email

    init() {
        _presenter = StateObject(wrappedValue: SignUpWithEmailPresenter())
    }
    
    var body: some View {
        
        switch selection {
        case .email:
            SignUpEmailForm(presenter: presenter)
        case .userInfomation:
            SignUpUserInfomationForm()
        case .questionnaire:
            SignUpQuestionnaire()
        }
    }
}
