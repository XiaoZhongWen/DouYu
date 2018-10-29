//
//  AnchorModel.swift
//  DouYu
//
//  Created by mye on 2018/9/17.
//  Copyright © 2018 肖仲文. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    
    @objc var icon_url : String = ""
    @objc var icon_name : String = "home_header_normal"
    @objc var small_icon_url : String = ""
    @objc var tag_name : String = ""
    @objc var tag_id : String = ""
    @objc var push_vertical_screen : String = ""
    @objc var push_nearby : String = ""
    @objc var anchors : [AnchorModel] = [AnchorModel]()
    @objc var room_list : [[String : NSObject]]? {
        didSet {
            guard let room_list = room_list else {
                return
            }
            for dict in room_list {
                let anchorModel = AnchorModel(dict: dict)
                anchors.append(anchorModel)
            }
        }
    }
    
    override init() {
        super.init()
    }
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override var description: String {
        var desc = ""
        desc.append("icon_url: \(icon_url)\n")
        desc.append("small_icon_url: \(small_icon_url)\n")
        desc.append("tag_name: \(tag_name)\n")
        desc.append("tag_id: \(tag_id)\n")
        desc.append("push_vertical_screen: \(push_vertical_screen)\n")
        desc.append("push_nearby: \(push_nearby)\n")
        desc.append("room_list:\n")
        for anchor in anchors {
            desc.append(anchor.description)
        }
        
        return desc
    }
}
