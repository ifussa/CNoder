//
//  Bundle+Extensions.swift
//  Patient
//
//  Created by Fussa on 2017/6/2.
//  Copyright © 2017年 gxwj. All rights reserved.
//

import Foundation

extension Bundle {
    
    /// 找出CFBundleName
    public var namespace: String {
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
}
