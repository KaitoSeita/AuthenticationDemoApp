//
//  AuthenticationPresenter.swift
//  AuthenticationDemo
//
//  Created by kaito seita on 2023/09/06.
//

import Foundation

final class AuthenticationPresenter: ObservableObject {
    
    func onTap() {
        Task {
            await registerUserInfo
        }
    }
    
    private func registerUserInfo() async {
        
    }
}
