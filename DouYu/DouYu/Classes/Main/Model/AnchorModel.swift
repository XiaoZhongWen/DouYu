//
//  AnchorGroup.swift
//  DouYu
//
//  Created by mye on 2018/9/17.
//  Copyright © 2018 肖仲文. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    
    @objc var room_id : String = ""
    @objc var vertical_src : String = ""
    @objc var cate_id : NSNumber = 0
    @objc var hot : NSNumber = 0
    @objc var avatar_small : String = ""
    @objc var avatar_mid : String = ""
    @objc var room_src : String = ""
    @objc var room_name : String = ""
    @objc var game_name : String = ""
    @objc var isVertical : NSNumber = 0
    @objc var owner_uid : NSNumber = 0
    @objc var ranktype : String = ""
    @objc var nickname : String = ""
    @objc var online : String = ""
    @objc var show_status : NSNumber = 0
    @objc var show_time : String = ""
    @objc var jumpUrl : String = ""
    @objc var subject : String = ""
    @objc var specific_catalog : String = ""
    @objc var specific_status : String = ""
    @objc var vod_quality : String = ""
    @objc var hn : NSNumber = 0
    @objc var nrt : NSNumber = 0
    @objc var child_id : NSNumber = 0
    @objc var rmf1 : NSNumber = 0
    @objc var rmf2 : NSNumber = 0
    @objc var rmf3 : NSNumber = 0
    @objc var rmf4 : NSNumber = 0
    @objc var rmf5 : NSNumber = 0
    @objc var show_type : NSNumber = 0
    @objc var is_noble_rec : NSNumber = 0
    @objc var anchor_city : String = ""
    @objc var push_ios : NSNumber = 0
    @objc var push_nearby : NSNumber = 0
    @objc var recomType : NSNumber = 0
    @objc var rpos : NSNumber = 0
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override var description: String {
        var desc = ""
        desc.append("room_id:\(room_id)\n")
        desc.append("vertical_src:\(vertical_src)\n")
        desc.append("cate_id:\(cate_id)\n")
        desc.append("hot:\(hot)\n")
        desc.append("avatar_small:\(avatar_small)\n")
        desc.append("room_src:\(room_src)\n")
        desc.append("room_name:\(room_name)\n")
        desc.append("game_name:\(game_name)\n")
        desc.append("isVertical:\(isVertical)\n")
        desc.append("owner_uid:\(owner_uid)\n")
        desc.append("ranktype:\(ranktype)\n")
        desc.append("nickname:\(nickname)\n")
        desc.append("online:\(online)\n")
        desc.append("show_status:\(show_status)\n")
        desc.append("avatar_mid:\(avatar_mid)\n")
        desc.append("jumpUrl:\(jumpUrl)\n")
        desc.append("rmf1:\(rmf1)\n")
        desc.append("rmf2:\(rmf2)\n")
        desc.append("rmf3:\(rmf3)\n")
        desc.append("rmf4:\(rmf4)\n")
        desc.append("rmf5:\(rmf5)\n")
        return desc
    }
}
