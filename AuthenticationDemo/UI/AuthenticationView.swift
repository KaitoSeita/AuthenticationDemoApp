//
//  ContentView.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/06.
//

import SwiftUI

// MARK: HOME VIEW
struct AuthenticationView: View {
    @StateObject private var presenter: AuthenticationPresenter
    
    init() {
        _presenter = StateObject(wrappedValue: AuthenticationPresenter())
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}
