//
//  Compass.swift
//  Cell
//
//  Created by Noah on 2021/8/27.
//

import UIKit
import SafariServices

class Compass {
    
    static let shared = Compass()
    
    private var _ocean: UIWindow?
    private var _ship: BaseNavigationController?
    private var _navigator: Navigator?
    
    static var ocean: UIWindow? {
        get { shared._ocean }
        set {
            shared._ocean = newValue
            shared._ship = BaseNavigationController(rootViewController: HomeViewController())
            shared._navigator = Navigator()
            
            shared._ocean?.backgroundColor = .dynamicColor(.white, .black)
            shared._ocean?.tintColor = .theme_white_dy
            shared._ocean?.rootViewController = shared._ship
        }
    }
    
    static var ship: BaseNavigationController? {
        shared._ship
    }
    
    static var navigator: Navigator? {
        shared._navigator
    }
}

extension Compass {
    
    enum Map: String {
        
        case homeRoot = "home/"
        case homeAction = "home/<action>"
        
        enum HomeMap:String {
            case goBackHome = "goBackHome"
            case sidebarShow = "sidebarShow"
            case sidebarHidden = "sidebarHidden"
            case popoverShow = "popoverShow"
            case searchPush = "searchPush"
            case publishPush = "publishPush"
            
            var actionPath: String { Map.homeRoot.oceanPath+self.rawValue }
        }
        
        case alert = "alert"
        
        static let oceanPrefix = "Cell://"
        var oceanPath: String { Map.oceanPrefix+self.rawValue }
    }
    
    fileprivate static func showWebView(url: URLConvertible, values: [String: Any], context: Any?) -> UIViewController? {
      guard let url = url.urlValue else { return nil }
      return SFSafariViewController(url: url)
    }
    
    fileprivate static func showAlert(navigator: Navigator) -> URLOpenHandlerFactory {
        return { url, values, context in
            guard let title = url.queryParameters["title"] else { return false }
            let message = url.queryParameters["message"]
            let confirm = url.queryParameters["confirm"]
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: confirm, style: .default, handler: nil))
            navigator.present(alertController)
            return true
        }
    }
}

extension Navigator {
    
    func equipBasicMap() {
        
        handle(Compass.Map.alert.oceanPath, Compass.showAlert(navigator: self))
        
        register("http://<path:_>", Compass.showWebView)
        register("https://<path:_>", Compass.showWebView)
                
        handle(Compass.Map.oceanPrefix+"<path:_>") { (url, values, context) -> Bool in
            // No navigator match, do analytics or fallback function here
            
            CLog("[Navigator] NavigationMap.\(#function):\(#line) - global fallback function is called")
            return true
        }
    }
}
