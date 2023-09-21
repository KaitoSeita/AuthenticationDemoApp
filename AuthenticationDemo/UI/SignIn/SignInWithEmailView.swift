//
//  SignInWithEmailPasswordView.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/07.
//

import SwiftUI

struct SignInWithEmailView: View {
    @StateObject private var presenter: SignInWithEmailPresenter
    
    private let interactor: SignInWithEmailInteractor
    
    init(interactor: SignInWithEmailInteractor) {
        self.interactor = interactor
        _presenter = StateObject(wrappedValue: SignInWithEmailPresenter(interactor: interactor))
    }

    var body: some View {
        Text("Hello, World!")
    }
}
