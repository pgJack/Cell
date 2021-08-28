//
//  Compass+Basic.swift
//  Cell
//
//  Created by Noah on 2021/8/29.
//

import UIKit
import SafariServices

extension Navigator {
    
    func equipBasicMap() {
        
        handle(Compass.entangle.oceanPath, Compass.entangling)
                
        handle(Compass.alert.oceanPath, Compass.showAlert(navigator: self))
        
        register("http://<path:_>", Compass.showWebView)
        register("https://<path:_>", Compass.showWebView)
                
        handle(Compass.oceanPrefix+"<path:_>") { (url, values, context) -> Bool in
            // No navigator match, do analytics or fallback function here
            
            CLog("[Navigator] NavigationMap.\(#function):\(#line) - global fallback function is called")
            return true
        }
    }
}

extension Compass {
    
    fileprivate static func showWebView(url: URLConvertible, values: [String: Any], context: Any?) -> UIViewController? {
      guard let url = url.urlValue else { return nil }
      return SFSafariViewController(url: url)
    }
    
    fileprivate static var entangling: URLOpenHandlerFactory {
        { url, values, context in
            CellSkipper.enterOcean(CellSkipper.ocean) 
            return true
        }
    }
    
    fileprivate static func showAlert(navigator: Navigator) -> URLOpenHandlerFactory {
        { [weak navigator] url, values, context in
            guard let title = url.queryParameters["title"] else { return false }
            let message = url.queryParameters["message"]
            let confirm = url.queryParameters["confirm"]
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: confirm, style: .default, handler: nil))
            navigator?.present(alertController)
            return true
        }
    }
}
