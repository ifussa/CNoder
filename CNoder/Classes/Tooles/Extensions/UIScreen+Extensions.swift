//
//  UIScreen+Extensions.swift
//  Patient
//
//  Created by Fussa on 2017/6/2.
//  Copyright © 2017年 gxwj. All rights reserved.
//

import UIKit

extension UIScreen {
    
    /// 屏幕物理宽度
    public static func wj_screenWidth() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    /// 屏幕的物理高度
    public static func wj_screenHeight() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    /// 屏幕的分辨率
    public static func wj_scale () -> CGFloat {
        return UIScreen.main.scale
    }
}
