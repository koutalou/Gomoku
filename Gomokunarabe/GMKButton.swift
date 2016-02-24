//
//  GMKButton.swift
//  Gomokunarabe
//
//  Created by Kodama.Kotaro on 2016/02/24.
//  Copyright © 2016年 Money Forward, Inc. All rights reserved.
//

import UIKit

@IBDesignable
class GMKButton: UIButton {
    var stone: Stone = .None
    
    override func didMoveToWindow() {
        initStyle()
    }
    
    // For override to initialize custom configure
    func initStyle() {
        stone = .Black
        backgroundColor = UIColor.grayColor()
        setRounded(radius: 10)
    }
    
    func toBlack() {
        stone = .Black
        backgroundColor = UIColor.blackColor()
        setRounded(radius: 10)
    }
    
    func toWhite() {
        stone = .White
        backgroundColor = UIColor.whiteColor()
        setRounded(radius: 10)
    }
    
    func setRounded(radius cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = (cornerRadius > 0)
    }
}