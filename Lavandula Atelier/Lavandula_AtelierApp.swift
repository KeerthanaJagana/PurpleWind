//
//  Lavandula_AtelierApp.swift
//  Lavandula Atelier
//
//  Created by Keerthana Jagana on 3/14/25.
//

import SwiftUI
import Firebase

@main
struct Lavandula_AtelierApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            //ContentView()
            SplashScreenView()
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
