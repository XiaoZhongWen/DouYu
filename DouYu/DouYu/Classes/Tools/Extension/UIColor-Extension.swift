//
//  UIColor-Extension.swift
//  DouYu
//
//  Created by mye on 2018/9/10.
//  Copyright © 2018 肖仲文. All rights reserved.
//

import UIKit
//import Foundation

extension UIColor {
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        self.init(red : r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}
