//
//  SignUpWithEmailStepIndicatorPresenter.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/10/11.
//

import SwiftUI

final class SignUpWithEmailStepIndicatorPresenter: ObservableObject {
    @Published var colorItems: [ColorModel] = []
    
    init() {
        colorSelecter(selection: .email)
    }
    
    func colorSelecter(selection: SignUpSelection){
        switch selection {
        case .email:
            colorItems = [ColorModel(color: .black), ColorModel(color: .gray), ColorModel(color: .gray)]
        case .userInfomation:
            colorItems = [ColorModel(color: .black), ColorModel(color: .black), ColorModel(color: .gray)]
        case .questionnaire:
            colorItems = [ColorModel(color: .black), ColorModel(color: .black), ColorModel(color: .black)]
        }
    }
}

