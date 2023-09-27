//
//  RoundedRectangle.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/27.
//

import SwiftUI

struct CustomizedRoundedRectangle<T: View>: View {
    let color: Color
    
    @ViewBuilder var content: () -> T
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .grayShadow()
            .frame(width: 330, height: 55)
            .foregroundColor(color)
            .overlay {
                content()
            }
    }
}
