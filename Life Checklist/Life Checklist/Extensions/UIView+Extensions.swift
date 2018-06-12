//
//  UIView+CornerRadius.swift
//  Meeof
//
//  Created by Dev on 8/7/17.
//  Copyright © 2017 Dev. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class DesignableView: UIView {
    // Corner Radius.
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    //Background Color.
    @IBInspectable var backColor: UIColor? {
        didSet {
            backgroundColor = backColor
        }
    }
    //Border Width.
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    //Border Color.
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    //Shadow Color
    @IBInspectable var shadowColor: UIColor? {
        didSet {
            layer.shadowColor = shadowColor?.cgColor
        }
    }
    
    //Shadow Opacity
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    //Shadow Radius
    @IBInspectable var shadowRadius: Float = 0 {
        didSet {
            layer.shadowRadius = CGFloat(shadowRadius)
            layer.masksToBounds = false
        }
    }
    
    //Shadow Radius
    @IBInspectable var shadowOffset: CGSize = CGSize.zero {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
}
