//
//  CloseButton.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/10/10.
//

import SwiftUI

struct CloseButton: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: String(resource: R.string.localizable.xmarkFillSymbol))
                    .resizable()
                    .foregroundColor(.gray.opacity(0.5))
                    .frame(width: 25, height: 25)
            })
        }
        .padding(.horizontal, 25)
    }
}
