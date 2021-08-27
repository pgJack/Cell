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
    
    func defaultBarStyle() {
        navigationBar.shadowImage = UIImage()
        navigationBar.barTintColor = .theme_black_dy
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.isTranslucent = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        defaultBarStyle()
        setBarAlpha(1)
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
