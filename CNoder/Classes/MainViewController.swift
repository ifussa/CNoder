//
//  MainViewController.swift
//  CNoder
//
//  Created by Fussa on 2017/6/13.
//  Copyright © 2017年 fussa. All rights reserved.
//

import UIKit
import Foundation

public let kMenuViewWidht = UIScreen.main.bounds.width * 0.8
fileprivate let kShowMenuAnimationTime = 0.3
fileprivate let knavBarHeight = 64
fileprivate let cellID = "cellID"

class MainViewController: UIViewController {
    // 自定义导航条
    lazy var fs_navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: Int(knavBarHeight)))
    // 自定义导航条目,
    lazy var fs_navigationItem = UINavigationItem()
    // 菜单栏
    lazy var menuView = MenuView.init(frame: CGRect(x: (-kMenuViewWidht), y: 0, width: kMenuViewWidht, height: UIScreen.main.bounds.height))
    fileprivate lazy var bgView  = UIView(frame: UIScreen.main.bounds)
    fileprivate var tableView: UITableView?
    fileprivate var topicsData = [Topics]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = UIColor.white
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
}


// MARK: - 设置UI
extension MainViewController {
    
    /// 设置UI
    fileprivate func setupUI() {
        setupNavigationBar()
        setupMenuView()
        setupTableview()
        setupShadowsView()
        setupRollToTopButton()
    }
    
    /// 设置导航栏
    private func setupNavigationBar() {
        if #available(iOS 11.0, *) {
//            fs_navigationBar.prefersLargeTitles = true
        }
        fs_navigationBar.barStyle = .black
        let itemImage = UIImage(named: "menu-button")
        let leftBarItem = UIBarButtonItem(image:itemImage, style:.plain, target: self,action: #selector(showSideMenuBar))
        fs_navigationItem.leftBarButtonItem = leftBarItem
        // 添加导航条
        view.addSubview(fs_navigationBar)
        // 添加自定义导航条目
        fs_navigationBar.items = [fs_navigationItem]
        fs_navigationItem.title = "首页"
        // 背景渲染颜色
        fs_navigationBar.barTintColor = UIColor.init(hexString: "##333333")
        // 字体颜色
        fs_navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        // 按钮字体颜色
        fs_navigationBar.tintColor = UIColor.white
    }
    
    
    /// 设置侧边菜单栏
    private func setupMenuView() {
        view.insertSubview(menuView, aboveSubview: fs_navigationBar)
    }
    
    /// 设置tableview
    private func setupTableview() {
        self.tableView = UITableView(frame: view.bounds, style: .grouped)
        self.tableView?.contentInset = UIEdgeInsetsMake(CGFloat(knavBarHeight), 0, 0, 0)
        self.tableView?.register(UINib(nibName: String(describing: HomeTableViewCell.self), bundle: nil), forCellReuseIdentifier: cellID)
        self.tableView?.rowHeight = 80
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        view.insertSubview(tableView!, belowSubview: fs_navigationBar)
    }
    
    /// 设置ShadowsView
    private func setupShadowsView() {
        bgView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        let tap =  UITapGestureRecognizer.init(target: self, action: #selector(showSideMenuBar))
        bgView.addGestureRecognizer(tap)
    }
    
    /// 设置滚动到顶部按钮
    private func  setupRollToTopButton() {
        let topButton = UIButton(frame: CGRect(x: kMenuViewWidht, y: UIScreen.main.bounds.height * 0.85, width: 50, height: 50))
        topButton.setImage(UIImage.init(named: "topUp"), for: .normal)
        topButton.setImage(UIImage.init(named: "topUp"), for: .highlighted)
        topButton.addTarget(self, action: #selector(rollToTop), for: .touchUpInside)
        topButton.cornerRadius = 25
        view.insertSubview(topButton, belowSubview: menuView)
    }
}

// MARK: - 网络请求
extension MainViewController {
    func getTopics() {
        HttpTool.getRequset(url: TOPICS_URL, params: nil , success: { (success) in
            let topics = success["data"] as? NSArray
            if ((topics?.count) != nil) {
                self.topicsData = [Topics]()
                for topic in topics! {
                    let t = Topics(JSON: (topic as? [String : Any])!)
                    self.topicsData.append(t!)
                }
            }
            self.tableView?.reloadData()
        })
    }
}

// MARK: - 逻辑处理
extension MainViewController {
    /// 显示侧边菜单栏
    @objc fileprivate func showSideMenuBar() {
        if menuView.frame.origin.x == -kMenuViewWidht {
            view.insertSubview(bgView, belowSubview: menuView)
        } else {
            bgView.removeFromSuperview()
        }
        UIView.animate(withDuration: kShowMenuAnimationTime) { [weak self] in
            if (self?.menuView.frame.origin.x == -kMenuViewWidht) {
                self?.menuView.frame.origin.x = 0
            } else {
                self?.menuView.frame.origin.x = -kMenuViewWidht
            }
        }
    }
    
    /// 滚动到顶部
    @objc fileprivate func rollToTop() {
        tableView?.scrollToTop()
    }
    
    /// 弹出扫描界面
    public func showScanViewController() {
        showSideMenuBar()
        // 等菜单界面退出后, 弹出扫码界面
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + kShowMenuAnimationTime) {
//            self.present(ScanViewController(), animated: true, completion: nil)
            self.navigationController?.pushViewController(ScanViewController(), animated: true)
        }
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.topicsData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? HomeTableViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed(String(describing: HomeTableViewCell.self), owner: nil, options: nil)?.first as? HomeTableViewCell
        }
        cell?.topic = self.topicsData[indexPath.row]
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        printLog(indexPath.row)
    }
}






