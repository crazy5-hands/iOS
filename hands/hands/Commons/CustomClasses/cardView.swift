//
//  cardView.swift
//  hands
//
//  Created by 山浦功 on 2018/05/21.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

@IBDesignable
class cardView: UIView {

    @IBInspectable var shadowOffset: CGSize = CGSize(width: 10, height: 10)
    @IBInspectable var shadowColor: UIColor = .white
    @IBInspectable var shadowOpacity: Float = 10
    @IBInspectable var cornerRadius: CGFloat = 30
    @IBInspectable var masksToBounds: Bool = false
    
    override func draw(_ rect: CGRect) {
        self.layer.masksToBounds = masksToBounds
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
    }
}
