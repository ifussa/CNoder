//
//  WJBaseViewController.swift
//  Patient
//
//  Created by Fussa on 2017/6/1.
//  Copyright © 2017年 gxwj. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

let kNavBarHeight = 64

class BaseViewController: UIViewController {
    // 自定义导航条
    lazy var fs_navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: Int(kNavBarHeight)))
    // 自定义导航条目,
    lazy var fs_navigationItem = UINavigationItem()
    
    var tableView: UITableView?
    
    // 刷新控件
    public var refreshControl: UIRefreshControl?
    // 是否上拉刷新
    public var isPullup = false
    // 是否下拉刷新
    public var isPulldown = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.random
        self.setupUI()
        self.loadData()
        SVProgressHUD.setDefaultStyle(.dark)
    }
    override var title: String? {
        didSet {
            self.fs_navigationItem.title = title
        }
    }

    // 加载数据方法, 在此基类中定义, 在子类中override
    public func loadData() {
        
    }
}


// MARK: - 界面设置
extension BaseViewController {

    public func setupUI() {
        // 取消自动缩进
//		automaticallyAdjustsScrollViewInsets = false
        self.setupNavigationBar()
        self.setupTableView()
    }    
    private func setupTableView() {
        self.tableView = UITableView(frame: view.bounds, style: .grouped)
        self.view.insertSubview(tableView!, belowSubview: fs_navigationBar)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        // 设置表格内容缩进
        self.tableView?.contentInset = UIEdgeInsetsMake(tabBarController?.tabBar.bounds.height ?? 49, 0, 0, 0)
        self.refreshControl = UIRefreshControl()
        self.tableView?.addSubview(refreshControl!)
        self.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }

    @objc private func refreshData() {
        isPulldown = true
        loadData()
    }

    /// 设置导航条
    private func setupNavigationBar() {
       
        if #available(iOS 11.0, *) {
            //            fs_navigationBar.prefersLargeTitles = true
        }
        self.fs_navigationBar.barStyle = .black
        // 添加导航条
        self.view.addSubview(fs_navigationBar)
        // 添加自定义导航条目
        self.fs_navigationBar.items = [fs_navigationItem]
        // 背景渲染颜色
        self.fs_navigationBar.barTintColor = UIColor.init(hexString: "##333333")
        // 字体颜色
        self.fs_navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        // 按钮字体颜色
        self.fs_navigationBar.tintColor = UIColor.white
        
    }

}


// MARK: - UITableViewDelegate, UITableViewDataSource
// 基类准备方法, 具体在子类中实现
extension BaseViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    // 在显示最后一行的时候, 进行上拉刷新
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let section = tableView.numberOfSections - 1
        if row < 0 || section < 0 {
            return
        }
        let count = tableView.numberOfRows(inSection: section)
        //如果是最后一行, 并且么有进行上拉刷新
        if row == (count - 1) && !self.isPullup {
            self.isPullup = true
            // 进行上拉刷新
            self.loadData()
        }

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }

}

// MARK: - UITabBarControllerDelegate
// 判断是否登录
//extension BaseViewController: UITabBarControllerDelegate {
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
////        let isLogin = UserTool.checkLogined()
////        if !isLogin && (viewController.childViewControllers.first?.isKind(of: ProfileViewController.self))! {
//            self.present(LoginViewController(), animated: true, completion: nil)
//            return false
////        }
////        return true
//    }
//}




