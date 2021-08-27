//
//  BaseViewController.swift
//  Cell
//
//  Created by Noah on 2021/8/26.
//

import UIKit

class BaseViewController: UIViewController {
    
    private var _lastMarineGoods: [String : Any]? = nil
    func receive(marineGoods: [String : Any]?) {
        _lastMarineGoods = marineGoods
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .dynamicColor(.white, .black)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}
