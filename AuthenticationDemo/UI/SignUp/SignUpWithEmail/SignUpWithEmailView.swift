//
//  SignUpWithEmailView.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/10/04.
//

import SwiftUI

// presenterの宣言はここ
// presenterにselectionを持たせて, EnvironmentObjectにするとか...

struct SignUpWithEmailView: View {
    @StateObject private var presenter: SignUpWithEmailPresenter

    init() {
        _presenter = StateObject(wrappedValue: SignUpWithEmailPresenter())
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
