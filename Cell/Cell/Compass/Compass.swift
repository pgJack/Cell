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
            registerMap(shared._navigator)
            
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
    
    static func registerMap(_ navigator: Navigator?) {
        
        guard let navigator = navigator else {
            return
        }
        
        navigator.handle(Map.homeAction.oceanPath, handleHomeAction)

        navigator.handle(Map.alert.oceanPath, showAlert(navigator: navigator))
        
        navigator.register("http://<path:_>", showWebView)
        navigator.register("https://<path:_>", showWebView)
                
        navigator.handle(Map.oceanPrefix+"<path:_>") { (url, values, context) -> Bool in
            // No navigator match, do analytics or fallback function here
            
            CLog("[Navigator] NavigationMap.\(#function):\(#line) - global fallback function is called")
            return true
        }
    }
    
    private static var handleHomeAction: URLOpenHandlerFactory {
        { url, values, context in
            guard let home = shared._ship?.viewControllers.first as? HomeViewController,
                  let action = url.urlValue?.lastPathComponent,
                  isNonnull(action) else {
                return false
            }
            
            switch Compass.Map.HomeMap.init(rawValue: action) {
            case .goBackHome:
                shared._ship?.popToRootViewController(animated: true)
            case .sidebarShow:
                home.homeSidebar.show(true)
            case .sidebarHidden:
                home.homeSidebar.dismiss(true)
            case .popoverShow:
                CLog("popover show")
            case .searchPush:
                CLog("search push")
            case .publishPush:
                CLog("publish push")
            default:
                return false
            }
            return true
        }
    }
    
    private static func showWebView(url: URLConvertible, values: [String: Any], context: Any?) -> UIViewController? {
      guard let url = url.urlValue else { return nil }
      return SFSafariViewController(url: url)
    }

    static func alert(title: String, message: String) {
        Compass.navigator?.open(Map.alert.oceanPath+"?title="+title+"&message="+message)
    }
    private static func showAlert(navigator: Navigator) -> URLOpenHandlerFactory {
        return { url, values, context in
            guard let title = url.queryParameters["title"] else { return false }
            let message = url.queryParameters["message"]
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            navigator.present(alertController)
            return true
        }
    }
}
