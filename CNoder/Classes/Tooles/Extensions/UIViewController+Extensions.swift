//
//  UIViewController+Extensions.swift
//  Patient
//
//  Created by Fussa on 2017/6/19.
//  Copyright © 2017年 gxwj. All rights reserved.
//

import Foundation
import UIKit

extension NSObject {
    
    /// 简单的提示框
    func showSingerAlert(_ message: String) {
        self.showSingerAlert(message, completionHandler: nil)
    }
    func showSingerAlert(_ message: String, completionHandler: (() -> Void)?) {
        let alertController = UIAlertController(title: "提示" ,message: message,preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确认", style: .default) { (_) in
            if completionHandler != nil {
                completionHandler!()
            }
        }
        alertController.addAction(okAction)
        // 顯示提示框
        let vc = UIApplication().keyWindow?.rootViewController
        vc?.present(alertController, animated: true, completion: nil)
    }
    func showAlert(_ message: String, confirm: (() -> Void)?) {
        let alertController = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确认", style: .default) { (_) in
            if confirm != nil {
                confirm!()
            }
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        let vc = UIApplication().keyWindow?.rootViewController
        vc?.present(alertController, animated: true, completion: nil)
    }
}

