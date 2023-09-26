//
//  ExtensionView.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/25.
//

import Foundation
import SwiftUI

extension View {
    
    func grayShadow() -> some View {
        ZStack{
            self.shadow(color: .white.opacity(0.8), radius: 10, x: -7, y: -7)
            self.shadow(color: .gray.opacity(0.3), radius: 10, x: 8, y: 8)
        }
    }
}
