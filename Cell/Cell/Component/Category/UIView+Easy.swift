//
//  UIView+Easy.swift
//  Cell
//
//  Created by Noah on 2021/8/27.
//

import UIKit

extension UIView {
    
    func shadow3D() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width:0, height:-1)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.1
    }
}
