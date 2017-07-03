//
//  Topics.swift
//  CNoder
//
//  Created by Fussa on 2017/7/3.
//  Copyright © 2017年 fussa. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper

//enum Tabs: String {
//    case ask = "问答"
//    case share = "分享"
//    case job = "招聘"
//    case good = "精华"
//}

class Topics: NSObject, Mappable  {
   
    var id: String?
    var author_id: String?
    var tab: String?
    var content: String?
    var title: String?
    var last_reply_at: String?
    var good: Bool?
    var top: Bool?
    var reply_count: Int?
    var visit_count: Int?
    var create_at: String?
    var author: User?
    var loginname: String?
    var avatar_url: String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        id              <- map["id"]
        author_id       <- map["author_id"]
        tab             <- map["tab"]
        content         <- map["content"]
        title           <- map["title"]
        last_reply_at   <- map["last_reply_at"]
        good            <- map["good"]
        top             <- map["top"]
        reply_count     <- map["reply_count"]
        visit_count     <- map["visit_count"]
        create_at       <- map["create_at"]
        author          <- map["author"]
        loginname       <- map["loginname"]
        avatar_url      <- map["avatar_url"]
        
    }
}



