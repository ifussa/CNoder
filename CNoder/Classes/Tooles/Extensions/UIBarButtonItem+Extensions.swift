//
//  UIBarButtonItem+Extensions.swift
//  Patient
//
//  Created by Fussa on 2017/6/2.
//  Copyright © 2017年 gxwj. All rights reserved.
//

import UIKit
extension UIBarButtonItem {
    
    
     /// UIBarButtonItem
     ///
     /// - Parameters:
     ///   - title: 标题
     ///   - fontSize: 文字大小
     ///   - target: target
     ///   - action: action
     ///   - isBack: 是否是返回按钮, 如果是则加上返回箭头
     convenience init(title: String, fontSize: CGFloat = 16, target: AnyObject?, action: Selector, isBack: Bool = false) {
        let btn: UIButton = UIButton.wj_textButton(title: title, fontSize: fontSize, normalColor: UIColor.white, highlightedColor: kNomalColor)
        if isBack {
            btn.setImage(UIImage.init(named: "leftBack"), for: UIControlState(rawValue: 0))
            btn.setImage(UIImage.init(named: "leftBack"), for: .highlighted)
            btn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -5, bottom: 0, right: 0)
            btn.size.height = 30
            btn.sizeToFit()
        }
        btn.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView: btn)
    }
}
