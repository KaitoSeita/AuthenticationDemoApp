//
//  UIApplication+CloseKeyboad.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/10/19.
//

import SwiftUI

extension UIApplication {
    
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
