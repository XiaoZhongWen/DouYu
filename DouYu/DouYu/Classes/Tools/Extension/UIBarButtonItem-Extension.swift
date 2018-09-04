//
//  UIBarButtonItem-Extension.swift
//  DouYu
//
//  Created by 肖仲文 on 2018/9/4.
//  Copyright © 2018 肖仲文. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    convenience public init(imageName : String, highLightImageName : String = "", size : CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: imageName), for: .normal)
        if highLightImageName != "" {
            btn.setImage(UIImage.init(named: highLightImageName), for: .highlighted)
        }
        if size != CGSize.zero {
            btn.frame = CGRect.init(origin: CGPoint.zero, size: size)
        } else {
            btn.sizeToFit()
        }
        self.init(customView: btn)
    }
}
