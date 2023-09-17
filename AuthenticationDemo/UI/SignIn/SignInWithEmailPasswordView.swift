//
//  SignInWithEmailPasswordView.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/07.
//

import SwiftUI

struct SignInWithEmailPasswordView: View {
    @StateObject private var presenter: SignInPresenter
    
    init() {
        _presenter = StateObject(wrappedValue: SignInPresenter())
    }

    var body: some View {
        Text("Hello, World!")
    }
}
