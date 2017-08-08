//
//  TopicDetailViewController.swift
//  CNoder
//
//  Created by Fussa on 2017/7/3.
//  Copyright © 2017年 fussa. All rights reserved.
//

import UIKit

class TopicDetailViewController: BaseViewController {
    var topicId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTopicInfo()
    }

}

// MARK: - 界面相关
extension TopicDetailViewController {
    override func setupUI() {
        super.setupUI()
//        self.setupNavigationBar()
    }
    private func setupNavigationBar() {
        fs_navigationItem.title = "详情"
        fs_navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", target: self, action:  #selector(back))
    }
}

// MARK: - 逻辑处理
extension TopicDetailViewController {
    @objc fileprivate func back() {
        self.navigationController?.popViewController(animated: true)
    }
}


// MARK: - 网络
extension TopicDetailViewController {
    func loadTopicInfo() {
        if let id = self.topicId {
            let dict: [String : AnyObject] = ["mdrender" : "false" as AnyObject]
            let url = TOPICS_INFO_URL + id
            HttpTool.getRequset(url: url, params: dict, success: { (success) in
                printLog(success)
            }, failture: { (error) in
                self.showSingerAlert(String(describing: error))
            })
        }
    }
}
