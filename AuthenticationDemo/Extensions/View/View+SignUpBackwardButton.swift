//
//  View+SignUpBackwardButton.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/10/11.
//

import SwiftUI

struct SignUpBackwardButton: ViewModifier {
    @Binding var selection: SignUpSelection
    
    let presenter: SignUpWithEmailPresenter
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(
                        action: {
                            presenter.onTapTransitionButton(direction: .back)
                            withAnimation(.easeOut(duration: 0.3)){
                                switch selection {
                                case .email:
                                    selection = .email
                                case .userInfomation:
                                    selection = .email
                                case .confirmation:
                                    selection = .userInfomation
                                }
                            }
                        }, label: {
                            Image(systemName: String(resource: R.string.localizable.backwardSymbol))
                        }
                    ).tint(.black)
                }
            }
            .navigationBarBackButtonHidden(true)
    }
}

extension View {
    
    func signUpBackwardButton(selection: Binding<SignUpSelection>, presenter: SignUpWithEmailPresenter) -> some View {
        self.modifier(SignUpBackwardButton(selection: selection, presenter: presenter))
    }
}
