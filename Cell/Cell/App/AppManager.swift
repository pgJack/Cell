//
//  AppDelegate.swift
//  Beem
//
//  Created by Noah on 2021/8/9.
//

import UIKit

class AppManager: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Override point for customization after application launch.
        
        Jailer(application)
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        
        return UISceneConfiguration(name: NSStringFromClass(Homeland.self), sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
        sceneSessions.forEach { session in
            CLog("\(session.configuration.name ?? "?")")
        }
    }
}

//MARK: App Guard
extension AppManager {
    func Jailer(_ application: UIApplication) {
        #if DEBUG
        #else
        var evidence = true
        do {
            let suspectPath = "/private/break.txt"
            try "1".write(toFile: suspectPath, atomically: true, encoding: .utf8)
            try FileManager.default.removeItem(atPath: suspectPath)
        } catch {
            evidence = false
        }
        
        if let suspect = URL(string: "cydia://"),
           application.canOpenURL(suspect) {
            evidence = true
        }
        
        ["/Applications/Cydia.app",
         "/Library/MobileSubstrate/MobileSubstrate.dylib",
         "/bin/bash",
         "/usr/sbin/sshd",
         "/etc/apt",
         "/usr/bin/ssh"].forEach {
            if FileManager.default.fileExists(atPath: $0) { evidence = true }
         }
        
        if evidence {
            exit(0)
        }
        #endif
    }
}

