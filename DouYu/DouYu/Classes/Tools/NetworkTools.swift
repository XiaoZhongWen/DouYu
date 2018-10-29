//
//  NetworkTools.swift
//  DouYu
//
//  Created by mye on 2018/9/17.
//  Copyright © 2018 肖仲文. All rights reserved.
//

import Alamofire

enum MethodType {
    case POST
    case GET
}

class NetworkTools: NSObject {
    class func requestData(type : MethodType,
                     url : String,
                     parameters : [String : String]? = nil,
                     fininshCallback : @escaping (_ result : AnyObject) -> ()) {
        DispatchQueue.global().async {
            var method = HTTPMethod.get
            switch type {
            case .POST:
                method = HTTPMethod.post
            case .GET:
                method = HTTPMethod.get
            }
            
            Alamofire.request(url, method: method, parameters: parameters, encoding: URLEncoding.default).responseJSON { (response) in
                guard let result = response.result.value else {
                    print(response.result.error ?? "error")
                    return
                }
                fininshCallback(result as AnyObject)
            }
        }
    }
}
