//
//  GlobeConst.swift
//  Patient
//
//  Created by Fussa on 2017/6/2.
//  Copyright © 2017年 gxwj. All rights reserved.
//

import Foundation
import UIKit

/// 自定义打印方法
///
/// - Parameters:
///   - message: 打印的消息
///   - file: 所在文件名
///   - method: 所在函数文件名
///   - line: 所在行
func printLog<T>(_ message: T,
              file: String = #file,
              method: String = #function,
              line: Int = #line) {
    #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)行], \(method): \(message)")
    #endif
}

let kAccessTokenString = "a2c27929-4c21-4d7b-bf02-6a7ae62169ac"

/// 屏幕相关

/// 颜色

let kNomalColorString: String = "#3D92F3"
let kNomalColor: UIColor = UIColor.init(hexString: kNomalColorString)!

/// App沙盒路径
func kAppPath() -> String! {
    return NSHomeDirectory()
}

/// Documents路径
func kBundleDocumentPath() -> String! {
    return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
}

/// Caches路径
func KCachesPath() -> String! {
    return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
}




