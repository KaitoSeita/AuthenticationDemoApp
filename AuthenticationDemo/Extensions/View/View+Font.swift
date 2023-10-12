//
//  View+Font.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/27.
//

import SwiftUI

struct CustomizedFont: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 19, design: .rounded))
            .foregroundColor(color)
            .bold()
    }
}

extension View {
    
    func customizedFont(color: Color) -> some View {
        self.modifier(CustomizedFont(color: color))
    }
}
