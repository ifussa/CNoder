//
//  ProfileHeaderView.swift
//  CNoder
//
//  Created by Fussa on 2017/6/13.
//  Copyright © 2017年 fussa. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileHeaderView: UIView {
    /// 背景图片
    @IBOutlet weak var bgImageView: UIImageView!
    /// 头像
    @IBOutlet weak var headerImageView: UIImageView!
    /// 用户名
    @IBOutlet weak var nameLabel: UILabel!
    /// 积分
    @IBOutlet weak var rewardCountLabel: UILabel!
    /// 注销按钮
    @IBOutlet weak var logoutButton: UIButton!
  
    @IBOutlet weak var loginButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        headerImageView.isHidden = true
        nameLabel.isHidden = true
        rewardCountLabel.isHidden = true
        logoutButton.isHidden = true
        self.getUserInfo()
    }
    

    @IBAction func logout(_ sender: UIButton) {
        self.showAlert("确定要注销吗？") { 
            UserTool.logoutCurrentUser()
        }
    }
    
    @IBAction func login(_ sender: UIButton) {
        let vc = parentViewController as! MainViewController
        vc.showScanViewController()
    }
 
    /// 获取用户信息
    func getUserInfo() {
        self.loginButton.isHidden = true
        self.headerImageView.isHidden = false
        self.nameLabel.isHidden = false
        self.rewardCountLabel.isHidden = false
        self.logoutButton.isHidden = false
        
        let user = UserTool.getCurrentLoginUser()
        let url = USER_URL + (user?.loginname)!
        HttpTool.getRequset(url: url) { (success) in
            let user = User(JSON: success["data"] as! [String: AnyObject])
            let currentUser = UserTool.getCurrentLoginUser()
            user?.accesstoken = currentUser?.accesstoken
            user?.success = currentUser?.success
            user?.id = currentUser?.id
            UserTool.saveUser(user!)
            self.setHeaderViewImage(url: (user?.avatar_url)!)
            self.nameLabel.text = user?.loginname!
            self.rewardCountLabel.text = user?.score != nil ? user?.score : "0"
            let vc = self.parentViewController as! MainViewController
            vc.getTopics()
        }
    }
    
    /// 设置头像
    ///
    /// - Parameter url: 头像地址
    func setHeaderViewImage(url: String) {
        self.headerImageView.sd_setImage(with: URL(string: url))
    }
}

extension ProfileHeaderView {
    fileprivate func setupUI() {
        self.loginButton.cornerRadius = 6
        self.headerImageView.cornerRadius = self.headerImageView.width * 0.5
    }
}
extension ProfileHeaderView {
//    func showScanViewController(completionHandler: @escaping () -> Void) {
//        completionHandler()
//    }
}

