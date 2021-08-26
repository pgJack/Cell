//
//  Color+Easy.swift
//  umbrella
//
//  Created by Noah on 2021/4/7.
//  Copyright © 2021 Rongcloud. All rights reserved.
//

import UIKit

public extension Int {
    func color(_ alpha: CGFloat = 1) -> UIColor {
        let redValue = CGFloat((self & 0xFF0000) >> 16)/255.0
        let greenValue = CGFloat((self & 0xFF00) >> 8)/255.0
        let blueValue = CGFloat(self & 0xFF)/255.0
        return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: alpha)
    }
}

public extension UIColor {
    
    class func dynamicColor(_ light: UIColor, _ dark: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return .init { (traitCollection) -> UIColor in
                traitCollection.userInterfaceStyle == .dark ? dark : light
            }
        }
        return light
    }
    
    func toImage(size:CGSize = CGSize(width: 1, height: 1),
                        text:NSAttributedString? = nil,
                        textRect:CGRect = CGRect.zero) -> UIImage {
        
        let rect = CGRect(origin: CGPoint.zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0);
        
        if let context = UIGraphicsGetCurrentContext() {
            
            context.setFillColor(self.cgColor)
            context.fill(rect)
            
            if let drawText = text {
                let textSize = drawText.size()
                let textX = (size.width - textSize.width) / 2
                let textY = (size.height - textSize.height) / 2
                drawText.draw(in: textRect == CGRect.zero ? CGRect(origin: CGPoint(x: textX, y: textY), size: textSize) : textRect)
            }
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image ?? UIImage();
    }
}
