//
//  User.swift
//  Patient
//
//  Created by Fussa on 2017/6/19.
//  Copyright © 2017年 gxwj. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper

let kLoginname = "loginname"
let kAvatarUrl = "avatar_url"
let kId = "id"
let kSuccess = "success"
let kAccesstoken = "accesstoken"
let kCreateAt = "create_at"
let kGithubUsername = "githubUsername"
let kRecentReplies = "recent_replies"
let kRecentTopics = "recent_topics"
let kScore = "score"


class User: NSObject, Mappable, NSCoding {
    
    //success: {"loginname":"ifussa","avatar_url":"https:\/\/avatars2.githubusercontent.com\/u\/15109750?v=3&s=120","id":"590bf131ee41dcb8037f864e","success":true}

    
    var accesstoken: String?
    var loginname: String?
    var avatar_url: String?
    var id: String?
    var success: Bool?
    var create_at: String?
    var githubUsername: String?
    var recent_replies: [String : AnyObject]?
    var recent_topics: [String : AnyObject]?
    var score: String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        accesstoken       <- map["accesstoken"]
        loginname         <- map["loginname"]
        avatar_url        <- map["avatar_url"]
        id                <- map["id"]
        success           <- map["success"]
        create_at         <- map["create_at"]
        githubUsername    <- map["githubUsername"]
        recent_replies    <- map["recent_replies"]
        recent_topics     <- map["recent_topics"]
        score             <- map["score"]
    }
    
    /// 归档时调用
    func encode(with aCoder: NSCoder) {
        aCoder.encode(accesstoken, forKey: kAccesstoken)
        aCoder.encode(loginname, forKey: kLoginname)
        aCoder.encode(avatar_url, forKey: kAvatarUrl)
        aCoder.encode(id, forKey: kId)
        aCoder.encode(success, forKey: kSuccess)
        aCoder.encode(create_at, forKey: kCreateAt)
        aCoder.encode(githubUsername, forKey: kGithubUsername)
        aCoder.encode(recent_replies, forKey: kRecentReplies)
        aCoder.encode(recent_topics, forKey: kRecentTopics)
        aCoder.encode(score, forKey: kScore)
    }
    /// 解档时调用
    required init?(coder aDecoder: NSCoder) {
        super.init()
        accesstoken = aDecoder.decodeObject(forKey: kAccesstoken) as? String
        loginname = aDecoder.decodeObject(forKey: kLoginname) as? String
        avatar_url = aDecoder.decodeObject(forKey: kAvatarUrl) as? String
        id = aDecoder.decodeObject(forKey: kId) as? String
        success = aDecoder.decodeObject(forKey:kSuccess) as? Bool
        create_at = aDecoder.decodeObject(forKey: kId) as? String
        githubUsername = aDecoder.decodeObject(forKey: kGithubUsername) as? String
        recent_replies = aDecoder.decodeObject(forKey: kRecentReplies) as? [String : AnyObject]
        recent_topics = aDecoder.decodeObject(forKey: kRecentTopics) as? [String : AnyObject]
        score = aDecoder.decodeObject(forKey: kScore) as? String
    }
}
