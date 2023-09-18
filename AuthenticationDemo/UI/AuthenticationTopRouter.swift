//
//  AuthenticationTopRouter.swift
//  AuthenticationDemo
//
//  Created by kaito-seita on 2023/09/06.
//

import Foundation

// PresenterがRouterへ画面遷移を依頼する
struct AuthenticationTopRouter {
    
}

// NavigationLinkを使ってViewを返すメソッドを定義
// AuthenticationTopViewからはSignInTopViewとSignUpTopViewへの遷移のみ存在
// SceneState?みたいなのをEnvironmentでSignInTopViewとSignUpTopViewで管理しておく必要がある
// Switch文で分岐させるだけ(returnでviewの返却？)
