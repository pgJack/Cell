//
//  UIResponder+RxSwift.swift
//  Beem
//
//  Created by Noah on 2021/8/13.
//

import UIKit
import RxSwift
import RxCocoa

private var key: Void?

extension UIResponder {
    var disposeBag: DisposeBag {
        get {
            if let bag = objc_getAssociatedObject(self, &key) as? DisposeBag  {
                return bag
            } else {
                let newBag = DisposeBag()
                objc_setAssociatedObject(self, &key, newBag, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return newBag
            }
        }
    }
}
