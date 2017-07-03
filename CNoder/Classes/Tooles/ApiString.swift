//
//  ApiString.swift
//  Patient
//
//  Created by Fussa on 2017/6/5.
//  Copyright © 2017年 gxwj. All rights reserved.
//

//接口名称相关

import Foundation
import UIKit
//import SVProgressHUD


#if DEBUG
//Debug状态下的测试API
let MAIN_URL            = "https://cnodejs.org/api/v1"
    
//Release状态下的线上API
    
#else
let MAIN_URL            = "https://cnodejs.org/api/v1"
    
#endif

/*******************接口***********************/

//common API

//登录注册
let TOPICS_URL                  = "/topics"                   //主题首页
let TOPICS_INFO_URL             = "/topic/"                   //主题详情
let NEW_TOPOCS_URL              = "/topics"                   //新建主题
let TOPOCS_UPDATE_URL           = "/topics/update"            //编辑主题

//主题收藏
let COLLECT_TOPOCS_URL          = "/topic_collect/collect"    //收藏主题
let DELETE_COLLECT_TOPOCS_URL   = "/topic_collect/de_collect" //取消主题
let TOPOCS_LIST_URL             = "/topic_collect/:loginname"//用户所收藏的主题
//评论
let NEW_TOPOCS_REPLIES_URL      = "/topic/:topic_id/replies"  //新建评论
let NEW_TOPOCS_UPS_URL          = "/reply/:reply_id/ups"      //为评论点赞

//用户
let USER_URL                    = "/user/"                    //用户详情
let ACCESS_TOKEN_URL            = "/accesstoken"              //验证 accessToken 的正确性
let MESSAGE_COUNT_URL           = "/message/count"            //获取未读消息数
let MESSAGE_URL                 = "/messages"                //获取已读和未读消息
let MESSAGE_MARK_ALL_URL        = "/message/mark_all"         //标记全部已读
let MESSAGE_MARK_ONE_URL        = "/message/mark_one/:msg_id" //标记单个消息为已读






