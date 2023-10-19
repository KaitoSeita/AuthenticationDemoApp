//
//  SignUpUserInfomationForm.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/10/02.
//

import SwiftUI

struct SignUpUserInfomationForm: View {
    @ObservedObject var user: SignUpUser
    
    @Binding var selection: SignUpSelection

    let presenter: SignUpWithEmailPresenter
    let indicatorPresenter: SignUpWithEmailStepIndicatorPresenter
    
    var body: some View {
        VStack(spacing: 15) {
            Explanation()            
            HeightSpacer(height: 80)
            VStack(alignment: .leading) {
                NameForm(user: user)
                HeightSpacer(height: 40)
                BirthdayDatePicker(user: user)
            }
            Spacer()
            ContinueButton(selection: $selection, presenter: presenter, name: user.userName)
            HeightSpacer(height: 80)
        }
        .onAppear {
            indicatorPresenter.colorSelecter(selection: selection)
        }
        .signUpBackwardButton(selection: $selection, presenter: presenter)
        .padding(.top, 70)
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
    @ObservedObject var user: SignUpUser
        
    var body: some View {
        HStack{
            Image(systemName: String(resource: R.string.localizable.userSymbol))
                .resizable()
                .foregroundColor(.gray.opacity(0.5))
                .frame(width: 25, height: 25)
            
            WidthSpacer(width: 20)
            
            TextField(String(resource: R.string.localizable.nameTag), text: $user.userName)
                .font(.title)
                .fontWeight(.heavy)
                .keyboardType(.alphabet)
                .autocapitalization(.none)
        }.padding(.horizontal, 50)
    }
}

private struct BirthdayDatePicker: View {
    @ObservedObject var user: SignUpUser
    
    @State private var isShowingDatePicker = false
    
    let dateLimit = Calendar(identifier: .gregorian).date(from: DateComponents(year: 2010, month: 1, day: 1))!
    let formatter = DateFormatter()
    
    init(user: SignUpUser) {
        self.user = user
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateStyle = .long
    }
    
    var body: some View {
        HStack {
            Image(systemName: String(resource: R.string.localizable.calendarSymbol))
                .resizable()
                .foregroundColor(.gray.opacity(0.5))
                .frame(width: 25, height: 25)
            
            WidthSpacer(width: 20)
            
            Text(formatter.string(from: user.birthdayDate))
                .foregroundColor(.black)
                .font(.title)
                .fontWeight(.heavy)
            Spacer()
        }
        .padding(.horizontal, 50)
        .onTapGesture {
            isShowingDatePicker.toggle()
        }
        .sheet(isPresented: $isShowingDatePicker, content: {
            HStack {
                DatePicker("",
                           selection: $user.birthdayDate,
                           in: ...dateLimit,
                           displayedComponents: .date)
                .datePickerStyle(.wheel)
                .presentationCornerRadius(20)
                .presentationDragIndicator(.visible)
                .environment(\.locale, Locale(identifier: "ja_JP"))
                .presentationDetents([.fraction(0.5)])
                WidthSpacer(width: 35)
            }
        })
    }
}

private struct ContinueButton: View {
    @Binding var selection: SignUpSelection
        
    let presenter: SignUpWithEmailPresenter
    let name: String
    
    var nameCount: Bool {
        name.count == 0
    }
    
    var body: some View {
        Button(action: {
            presenter.onTapTransitionButton(direction: .forward)
            withAnimation(.easeOut(duration: 0.3)) {
                selection = .confirmation
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
