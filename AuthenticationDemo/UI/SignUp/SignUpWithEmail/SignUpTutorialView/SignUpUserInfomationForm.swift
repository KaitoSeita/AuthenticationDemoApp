//
//  SignUpUserInfomationForm.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/10/02.
//

import SwiftUI

struct SignUpUserInfomationForm: View {
    let indicatorPresenter: SignUpWithEmailStepIndicatorPresenter
    
    @Binding var selection: SignUpSelection
    
    @State private var firstName = ""
    @State private var lastName = ""

    var body: some View {
        VStack(spacing: 15) {
            Explanation()
            HeightSpacer(height: 100)
            NameForm(type: .first, firstName: $firstName, lastName: $lastName)
            NameForm(type: .last, firstName: $firstName, lastName: $lastName)
            
            Spacer()
        }
        .onAppear {
            indicatorPresenter.colorSelecter(selection: selection)
        }
        .signUpBackwardButton(selection: $selection)
        .padding(.top, 70)
        .navigationBarBackButtonHidden(true)
    }
}

private struct Explanation: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(R.string.localizable.createProfileTitle)
                .font(.system(.title, design: .rounded))
                .bold()
            Text(R.string.localizable.createProfileSubTitle)
                .font(.system(size: 12, design: .rounded))
                .bold()
            HeightSpacer(height: 20)
            Text(R.string.localizable.createProfileExplanation)
                .font(.system(size: 12, design: .rounded))
                .bold()
        }
    }
}

private struct NameForm: View {
    let type: InputNameType
    
    @Binding var firstName: String
    @Binding var lastName: String
    
    var body: some View {
        CustomizedRoundedRectangle(color: Color.white, content: {
            HStack{
                switch type {
                case .last:
                    
                    Spacer()
                case .first:
                    
                    Spacer()
                }
            }.padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
        })
    }
}
