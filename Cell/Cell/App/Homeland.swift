//
//  Homeland.swift
//  Cell
//
//  Created by Noah on 2021/8/26.
//

import UIKit

//MARK: App Life Cycle
class Homeland: UIResponder, UIWindowSceneDelegate {
    
    static var homeWindow: UIWindow?

    var window: UIWindow? {
        didSet {
            Homeland.homeWindow = window
        }
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.backgroundColor = .dynamicColor(.white, .black)
        window.tintColor = .theme_black_dy
        window.rootViewController = BaseNavigationController(rootViewController: HomeViewController())
        self.window = window

        window.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        
        CLog("\(scene.session.configuration.name ?? "?")")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        
        CLog("\(scene.session.configuration.name ?? "?")")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        
        CLog("\(scene.session.configuration.name ?? "?")")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        
        CLog("\(scene.session.configuration.name ?? "?")")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        CLog("\(scene.session.configuration.name ?? "?")")
    }
}
