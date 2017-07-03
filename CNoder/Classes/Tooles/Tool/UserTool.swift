//
//  UserTool.swift
//  Patient
//
//  Created by Fussa on 2017/6/19.
//  Copyright © 2017年 gxwj. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper
public let kCurrentLoginUser = "currentLoginUser"
let kEncryptPassword = "com.guanxinwanjia.www"

class UserTool: NSObject {
    
    /// 登录
    func Login(_ accesstoken: String) {
        UserTool.logoutCurrentUser()
        let dict = ["accesstoken": accesstoken]
        HttpTool.postRequest(url: ACCESS_TOKEN_URL, params: dict as [String : AnyObject], success: { (success) in
            //success: {"loginname":"ifussa","avatar_url":"https:\/\/avatars2.githubusercontent.com\/u\/15109750?v=3&s=120","id":"590bf131ee41dcb8037f864e","success":true}
            let user = User(JSON: success)
            user?.accesstoken = accesstoken
            UserTool.saveUser(user!)
            let v = ProfileHeaderView()
            v.getUserInfo()
        }, failture: { (error) in
            printLog(error)
        })
    }
    
    /// 存储当前用户
    static func saveUser(_ user: User) {
        encryptUser(user)
        let data = NSKeyedArchiver.archivedData(withRootObject: user)
        UserDefaults.save(data, key: kCurrentLoginUser)
    }
    
    /// 注销当前用户
    static func logoutCurrentUser() {
        let data = UserDefaults.getObjectForKey(kCurrentLoginUser)
        guard data != nil else { return }
        let user = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! User
        user.accesstoken = nil
        user.loginname = nil
        user.id = nil
        let data1 = NSKeyedArchiver.archivedData(withRootObject: user)
        UserDefaults.save(data1, key: kCurrentLoginUser)
    }
    
    /// 判断是否登录
    static func checkLogined() -> Bool{
        let token = (getCurrentLoginUser()?.id)
        if let _ = token {
            return true
        }
        return false
    }
    
    /// 获取当前用户
    static func getCurrentLoginUser() -> User? {
        let data = UserDefaults.getObjectForKey(kCurrentLoginUser)
        if data == nil {return nil}
        let user = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! User
        decryptUser(user)
        return user
    }
    
    /// 加密当前用户
    static func encryptUser(_ user: User) {
        user.accesstoken = FSAES.encrypt(user.accesstoken, password: kEncryptPassword)
    }
    
    /// 解密当前用户
    static func decryptUser(_ user: User) {
        user.accesstoken = FSAES.decrypt(user.accesstoken, password: kEncryptPassword)
    }
  
}
