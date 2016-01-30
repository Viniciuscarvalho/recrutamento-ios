//
//  RoundedCornersView.swift
//  recrutamento-ios
//
//  Created by Vinicius Carvalho on 30/01/16.
//  Copyright © 2016 Vinicius Carvalho. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedCornersView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
}
