//
//  MenuView.swift
//  CNoder
//
//  Created by Fussa on 2017/6/14.
//  Copyright © 2017年 fussa. All rights reserved.
//

import UIKit

fileprivate let cellID = "cellID"
fileprivate let kHeaderViewHeight = 220

class MenuView: UIView {

    fileprivate var tableView: UITableView?
    lazy var headerView = UIView.loadFromNib(named: "ProfileHeaderView")
    fileprivate lazy var menuList: Array = [
        ["最新","分享","文档","招聘 "],
        ["设置","分享","关于"]
    ]

    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = UIColor.white
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - 设置UI
extension MenuView {
    fileprivate func setupUI() {
        setupHeaderView()
        setupTableview()
    }

    /// 设置headerView
    private func setupHeaderView() {
        headerView?.frame = CGRect(x: 0, y: 0, width: Int(frame.width), height: Int(kHeaderViewHeight))
        addSubview(headerView!)
    }
    
    /// 设置Tableview
    private func setupTableview() {
        tableView = UITableView(frame: bounds, style: .grouped)
        tableView?.contentInset = UIEdgeInsetsMake(CGFloat(kHeaderViewHeight), 0, 0, 0)
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView?.delegate = self
        tableView?.dataSource = self
        insertSubview(tableView!, belowSubview: headerView!)
    }
}

extension MenuView {
  
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MenuView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        cell?.textLabel?.text = menuList[indexPath.section][indexPath.row]
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        printLog(indexPath.row)
    }
}
