//
//  NSDate-Extension.swift
//  DouYu
//
//  Created by mye on 2018/9/17.
//  Copyright © 2018 肖仲文. All rights reserved.
//

import Foundation

extension NSDate {
    class func timeinterval() -> String {
        let date = NSDate()
        let timeinterval = Int(date.timeIntervalSince1970)
        return "\(timeinterval)"
    }
}
