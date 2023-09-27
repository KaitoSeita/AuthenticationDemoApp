//
//  NavigationStack+BackwardButton.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/27.
//

import SwiftUI
import RswiftResources

struct CustomBackwardButton: ViewModifier {
    
    @Environment(\.dismiss) var dismiss

    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(
                        action: {
                            dismiss()
                        }, label: {
                            Image(systemName: String(resource: R.string.localizable.backwardSymbol))
                        }
                    ).tint(.black)
                }
            }
    }
}

extension View {
    
    func customBackwardButton() -> some View {
        self.modifier(CustomBackwardButton())
    }
}
