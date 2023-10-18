//
//  SignUpQuestionnaire.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/10/04.
//

import SwiftUI

struct SignUpQuestionnaire: View {
    @ObservedObject var presenter: SignUpWithEmailPresenter
    let indicatorPresenter: SignUpWithEmailStepIndicatorPresenter
    
    @Binding var selection: SignUpSelection
    @ObservedObject var user: SignUpUser

    var body: some View {
        VStack(spacing: 15) {
            Text("")
            
            ContinueButton(user: user, presenter: presenter)
        }
        .onAppear {
            indicatorPresenter.colorSelecter(selection: selection)
        }
        .padding(.top, 50)
        .signUpBackwardButton(selection: $selection)
        .navigationDestination(isPresented: $presenter.isShowingSuccessView, destination: {
            SignUpSuccessView()
                .navigationBarBackButtonHidden(true)
        })
        .toast(isShowingErrorMessage: $presenter.isShowingErrorMessage,
               isShowingLoadingToast: $presenter.isShowingLoadingToast,
               errorMessage: presenter.errorMessage)
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

private struct BirthdayForm: View {
    @Binding var ageSelection: [AgeSelection]
        
    //    @State private var ageSelection: [AgeSelection] = [AgeSelection(age: 10, isSelected: false),
    //                                                       AgeSelection(age: 20, isSelected: false),
    //                                                       AgeSelection(age: 30, isSelected: false),
    //                                                       AgeSelection(age: 40, isSelected: false),
    //                                                       AgeSelection(age: 50, isSelected: false),
    //                                                       AgeSelection(age: 60, isSelected: false)]
    var body: some View {
        // グリッドはUI的にださいのでGeometryEffectを使うようなおもろい選択式のものに変更したい
        VStack(spacing: 10) {
            ForEach($ageSelection, id: \.self) { $items in
                HStack {
                    Button(action: {
                        withAnimation(.linear) {
                            // すべてfalseに変更後にtrue
                            
                            items.isSelected = true
                        }
                    }, label: {
                        if items.isSelected {
                            Image(systemName: "circle.inset.filled")
                        } else {
                            Image(systemName: "circle")
                        }
                    })
                    .foregroundColor(.gray)
                    Text("\(String(items.age))代")
                        .font(.system(size: 15, design: .rounded))
                        .bold()
                }
            }
        }
    }
}

private struct ContinueButton: View {
    @ObservedObject var user: SignUpUser
    
    let presenter: SignUpWithEmailPresenter
    
    var body: some View {
        Button(action: {
            presenter.onTapSignUpButton(email: user.email, password: user.password)
        }, label: {
            CustomizedRoundedRectangle(color: Color.black, content: {
                Text(R.string.localizable.continue)
                    .customizedFont(color: .white)
            })
//            if {
//                CustomizedRoundedRectangle(color: Color.black, content: {
//                    Text(R.string.localizable.continue)
//                        .customizedFont(color: .white)
//                })
//            } else {
//                CustomizedRoundedRectangle(color: .gray.opacity(0.1), content: {
//                    Text(R.string.localizable.continue)
//                        .customizedFont(color: .black)
//                })
//            }
        })
//        .disabled(!presenter.onInputEmailAndPassword(email: email, password: password, reInputPassword: reInputPassword))
    }
}
