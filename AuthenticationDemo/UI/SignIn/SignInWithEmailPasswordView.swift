//
//  SignInWithEmailPasswordView.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/07.
//

import SwiftUI

struct SignInWithEmailPasswordView: View {
    @StateObject private var presenter: SignInWithEmailPasswordPresenter
    
    private let interactor: SignInWithEmailPasswordInteractor
    
    init(interactor: SignInWithEmailPasswordInteractor) {
        self.interactor = interactor
        _presenter = StateObject(wrappedValue: SignInWithEmailPasswordPresenter(interactor: interactor))
    }

    var body: some View {
        Text("Hello, World!")
    }
}
