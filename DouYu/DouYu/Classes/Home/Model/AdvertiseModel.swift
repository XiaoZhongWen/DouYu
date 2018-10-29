//
//  AdvertiseModel.swift
//  DouYu
//
//  Created by mye on 2018/9/25.
//  Copyright © 2018 肖仲文. All rights reserved.
//

import UIKit

class AdvertiseModel: NSObject {
    @objc var id: NSNumber = 0
    @objc var main_id: NSNumber = 0
    @objc var source: NSNumber = 0
    @objc var oa_source: NSNumber = 0
    @objc var title: String = ""
    @objc var pic_url: String = ""
    @objc var tv_pic_url: String = ""
//    @objc var anchor: AnchorModel?
//    @objc var room: [String: NSObject]? {
//        didSet {
//            guard let room = room else {
//                return
//            }
//            anchor = AnchorModel.init(dict: room)
//        }
//    }
    
    override init() {
        
    }
    
    init(dict: [String: NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
