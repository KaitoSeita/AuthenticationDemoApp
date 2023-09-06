//
//  ContentView.swift
//  AuthenticationDemo
//
//  Created by kaito seita on 2023/09/06.
//

import SwiftUI

struct AuthenticationView: View {
    // FIXME: init()でイニシャライズに変更
    @State private var presenter: AuthenticationPresenter = AuthenticationPresenter()
    
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

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
