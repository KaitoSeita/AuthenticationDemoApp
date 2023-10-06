//
//  SuccessView.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/28.
//

import SwiftUI
import RswiftResources

struct SuccessView: View {
    var body: some View {
        VStack {
            Text(R.string.localizable.successViewTitle)
                .font(.system(.title, design: .rounded))
                .bold()
            Text(R.string.localizable.successViewSubTitle)
                .font(.system(size: 12, design: .rounded))
                .bold()
        }
    }
}
