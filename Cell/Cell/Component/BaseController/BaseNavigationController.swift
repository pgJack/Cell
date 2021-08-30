//
//  BaseNavigationController.swift
//  Cell
//
//  Created by Noah on 2021/8/11.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    func setBarAlpha(_ alpha: CGFloat) {
        navigationBar.subviews.first?.alpha = alpha
    }
    
    func setBarBackgroundColor(_ color: UIColor) {
        navigationBar.barTintColor = color
    }
    
    func setBarItemColor(_ color: UIColor) {
        navigationBar.tintColor = color
        navigationBar.titleTextAttributes = [.foregroundColor: color]
    }
    
    func setDefaultBarAppearance() {
        setBarAlpha(1)
        setBarBackgroundColor(.theme_black_dy)
        setBarItemColor(.white)
    }
    
    func setDefaultBarStyle() {
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setDefaultBarStyle()
        setDefaultBarAppearance()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }
    
    override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
}
