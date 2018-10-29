//
//  RecommandViewModel.swift
//  DouYu
//
//  Created by mye on 2018/9/17.
//  Copyright © 2018 肖仲文. All rights reserved.
//

import UIKit

class RecommandViewModel: NSObject {
    var anchorGroups = [AnchorGroup]()
    var advertises = [AdvertiseModel]()
    private var prettyGroup : AnchorGroup = AnchorGroup()
    private var bigDataGroup : AnchorGroup = AnchorGroup()
}

// MARK:- 请求网络数据
extension RecommandViewModel {
    func requestData(finish: @escaping ()->()) -> Void {
        let parameters = ["limit" : "4", "offset" : "0", "time" : NSDate.timeinterval()]
        
        let dispatchGroup = DispatchGroup()
        // 1. 推荐数据
        dispatchGroup.enter()
        NetworkTools.requestData(type: .GET, url: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : NSDate.timeinterval()]) { (result) in
            guard let responseData = result as? [String : NSObject] else {
                return
            }
            guard let arrayM = responseData["data"] as? [[String : NSObject]] else {
                return
            }
            self.bigDataGroup.icon_name = "home_header_hot"
            self.bigDataGroup.tag_name = "热门"
            for dict in arrayM {
                var param = dict
                if let online = param["online"] as? NSNumber {
                    param["online"] = "\(online.int16Value)" as NSObject
                }
                if let room_id = param["room_id"] as? NSNumber {
                    param["room_id"] = "\(room_id.int16Value)" as NSObject
                }
                let anchorModel = AnchorModel.init(dict: param)
                self.bigDataGroup.anchors.append(anchorModel)
            }
            dispatchGroup.leave()
        }
        
        // 2. 颜值数据
        dispatchGroup.enter()
        NetworkTools.requestData(type: .GET, url: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            guard let responseData = result as? [String : NSObject] else {
                return
            }
            guard let arrayM = responseData["data"] as? [[String : NSObject]] else {
                return
            }
            self.prettyGroup.icon_name = "home_header_phone"
            self.prettyGroup.tag_name = "颜值"
            for dict in arrayM {
                var param = dict
                if let show_status = param["show_status"] as? String {
                    param["show_status"] = NSNumber.init(integerLiteral: Int(show_status)!)
                }
                if let owner_uid = param["owner_uid"] as? String {
                    param["owner_uid"] = NSNumber.init(integerLiteral: Int(owner_uid)!)
                }
                if let ranktype = param["ranktype"] as? NSNumber {
                    param["ranktype"] = "\(ranktype.int16Value)" as NSObject
                }
                if let online = param["online"] as? NSNumber {
                    param["online"] = "\(online.int16Value)" as NSObject
                }
                let anchorModel = AnchorModel.init(dict: param)
                self.prettyGroup.anchors.append(anchorModel)
            }
            dispatchGroup.leave()
        }
        
        // 3. 游戏数据
        dispatchGroup.enter()
        NetworkTools.requestData(type: .GET, url: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            guard let responseData = result as? [String : NSObject] else {
                return
            }
            guard let arrayM = responseData["data"] as? [[String : NSObject]] else {
                return
            }
            for dict in arrayM {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finish()
        }
    }
    
    // 4. 轮播图数据 http://www.douyutv.com/api/v1/slide/6?version=2.300
    func requestAdvertiseData(finish: @escaping ()->()) -> Void {
        NetworkTools.requestData(type: .GET, url: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version":"2.300"]) { (result) in
            guard let responseData = result as? [String: NSObject] else {return}
            guard let arrayM = responseData["data"] as? [[String: NSObject]] else {return}
            for dict in arrayM {
                let advertiseModel = AdvertiseModel.init(dict: dict)
                self.advertises.append(advertiseModel)
            }
            DispatchQueue.main.async {
                finish()
            }
        }
    }
    
}
