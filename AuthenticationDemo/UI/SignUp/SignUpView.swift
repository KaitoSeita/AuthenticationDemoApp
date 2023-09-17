//
//  SignUpView.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/07.
//

import SwiftUI

struct SignUpView: View {
    @StateObject private var presenter: SignUpPresenter
    
    init() {
        _presenter = StateObject(wrappedValue: SignUpPresenter())
    }

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

private struct SignUpWithApple: View {
    
    var body: some View {
        VStack{
            
        }
    }
}

private struct SignUpWithGoogle: View {
    
    var body: some View {
        VStack{
            
        }
    }
}
