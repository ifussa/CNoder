//
//  UIButton+Extensions.swift
//  Patient
//
//  Created by Fussa on 2017/6/2.
//  Copyright © 2017年 gxwj. All rights reserved.
//

import UIKit

extension UIButton {
    
    /// 创建文本按钮
    ///
    /// - Parameters:
    ///   - title: 按钮标题
    ///   - fontSize: 标普提文字大小
    ///   - normalColor: 默认颜色
    ///   - highlightedColor: 高亮颜色
    ///   - backgroundImageName: 背景图片名称
    /// - Returns: 按钮
    public static func wj_textButton(title: String, fontSize: CGFloat, normalColor: UIColor, highlightedColor: UIColor, backgroundImageName: String?) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(normalColor, for: .normal)
        button.setTitleColor(highlightedColor, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        if let backgroundImageName = backgroundImageName {
            button.setBackgroundImage(UIImage.init(named: backgroundImageName), for: .normal)
            button.setBackgroundImage(UIImage.init(named: backgroundImageName + "_highlighted"), for: .highlighted)
        }
        button.sizeToFit()
        return button
    }
    
    
    /// 创建文本按钮
    ///
    /// - Parameters:
    ///   - title: 按钮标题
    ///   - fontSize: 文字大小
    ///   - normalColor: 默认颜色
    ///   - highlightedColor: 高亮颜色
    /// - Returns: 按钮
    public static func  wj_textButton(title: String, fontSize: CGFloat, normalColor: UIColor, highlightedColor: UIColor) -> UIButton {
        return wj_textButton(title: title, fontSize: fontSize, normalColor: normalColor, highlightedColor: highlightedColor, backgroundImageName: nil)
    }
    
    
    /// 创建图片按钮
    ///
    /// - Parameters:
    ///   - imageName: 按钮图片
    ///   - backgroundImageName: 背景图片
    /// - Returns: 按钮
    public static func wj_imageButton(imageName: String, backgroundImageName: String?) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage.init(named: imageName), for: .normal)
        button.setImage(UIImage.init(named: imageName + "_highlighted"), for: .highlighted)
        if let backgroundImageName = backgroundImageName {
            button.setBackgroundImage(UIImage.init(named: backgroundImageName), for: .normal)
            button.setBackgroundImage(UIImage.init(named: backgroundImageName+"_highlighted"), for: .highlighted)
        }
        button.sizeToFit()
        return button
    }

}

