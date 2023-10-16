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
    @ObservedObject var user: SignUpUser

    var body: some View {
        VStack(spacing: 15) {
            Explanation()
            HeightSpacer(height: 80)
            NameForm(user: user)
            HeightSpacer(height: 30)
            BirthdayDatePicker(user: user)
            Spacer()
            ContinueButton(selection: $selection, name: user.userName)
            HeightSpacer(height: 80)
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
        VStack {
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
    @ObservedObject var user: SignUpUser
        
    var body: some View {
        CustomizedRoundedRectangle(color: Color.white, content: {
            HStack{
                Image(systemName: String(resource: R.string.localizable.userSymbol))
                    .foregroundColor(.gray.opacity(0.5))
                    .frame(width: 10, height: 10)
                
                WidthSpacer(width: 20)

                TextField(String(resource: R.string.localizable.nameTag), text: $user.userName)
                    .font(.system(.body, design: .rounded))
                    .keyboardType(.alphabet)
                    .autocapitalization(.none)
            }.padding(.horizontal, 25)
        })
    }
}

private struct BirthdayDatePicker: View {
    @ObservedObject var user: SignUpUser
    
    var body: some View {
        DatePicker("", selection: $user.birthDay, displayedComponents: .date)
    }
}

private struct ContinueButton: View {
    @Binding var selection: SignUpSelection
        
    let name: String
    
    var nameCount: Bool {
        name.count == 0
    }
    
    var body: some View {
        Button(action: {
            withAnimation(.linear) {
                selection = .questionnaire
            }
        }, label: {
            if !nameCount {
                CustomizedRoundedRectangle(color: Color.black, content: {
                    Text(R.string.localizable.continue)
                        .customizedFont(color: .white)
                })
            } else {
                CustomizedRoundedRectangle(color: .gray.opacity(0.1), content: {
                    Text(R.string.localizable.continue)
                        .customizedFont(color: .black)
                })
            }
        })
        .disabled(nameCount)
    }
}

#Preview {
    SignUpUserInfomationForm(indicatorPresenter: SignUpWithEmailStepIndicatorPresenter(), selection: .constant(.email), user: SignUpUser())
}
