//
//  AuthenticationDemoApp.swift
//  AuthenticationDemo
//
//  Created by kaito seita on 2023/09/06.
//

import SwiftUI
import FirebaseCore

@main
struct AuthenticationDemoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            AuthenticationView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
