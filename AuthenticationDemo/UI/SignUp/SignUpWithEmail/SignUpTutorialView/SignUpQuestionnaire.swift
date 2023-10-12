//
//  SignUpQuestionnaire.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/10/04.
//

import SwiftUI

struct SignUpQuestionnaire: View {
    let indicatorPresenter: SignUpWithEmailStepIndicatorPresenter
    
    @Binding var selection: SignUpSelection

    var body: some View {
        VStack(spacing: 15) {
            Text("")
        }
        .onAppear {
            indicatorPresenter.colorSelecter(selection: selection)
        }
        .padding(.top, 50)
        .navigationBarBackButtonHidden(true)
    }
}
