//
//  BaseNavigationController.swift
//  CNoder
//
//  Created by Fussa on 2017/7/3.
//  Copyright © 2017年 fussa. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isHidden = true
    }
    
    /// 重写push方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            if let vc = viewController as? BaseViewController {
                var title = "返回"
                if childViewControllers.count == 1 {
                    title = childViewControllers.first? .title ?? "返回"
                }
                vc.fs_navigationItem.leftBarButtonItem = UIBarButtonItem(title: title, target: self, action: #selector(popToParent), isBack: true)
            }
        }
        super.pushViewController(viewController, animated: animated)
    }
    /// POP 返回到上一级控制器
    @objc private func popToParent() {
        popViewController(animated: true)
    }
}
