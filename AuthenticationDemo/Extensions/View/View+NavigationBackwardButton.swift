//
//  View+NavigationBackwardButton.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/27.
//

import SwiftUI

struct CustomBackwardButton: ViewModifier {
    
    @Environment(\.dismiss) var dismiss
    
    private let edgeWidth: Double = 30
    private let baseDragWidth: Double = 30

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
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
            .gesture (
                DragGesture().onChanged { value in
                    if value.startLocation.x < edgeWidth && value.translation.width > baseDragWidth {
                        dismiss()
                    }
                }
            )
    }
}

extension View {
    
    func customBackwardButton() -> some View {
        self.modifier(CustomBackwardButton())
    }
}
