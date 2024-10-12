//
//  SDSharedUIApp.swift
//  SDSharedUI
//
//  Created by Ankit Kumar on 01/08/24.
//

import SwiftUI

@main
struct SDSharedUIApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        AppInitializiation.initialize()
        return true
    }
}
