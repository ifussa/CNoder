//
//  ScannerBackgroundView.swift
//  CNoder
//
//  Created by Fussa on 2017/6/22.
//  Copyright © 2017年 fussa. All rights reserved.
//

import UIKit

class ScannerBackgroundView: UIView {
    
    //屏幕扫描区域视图
    let barcodeView = UIView(frame: CGRect(x: UIScreen.wj_screenWidth() * 0.2,
                                           y: UIScreen.wj_screenHeight() * 0.35,
                                           width: UIScreen.wj_screenWidth() * 0.6,
                                           height: UIScreen.wj_screenWidth() * 0.6))
    //扫描线
    let scanLine = UIImageView()
    var scanning : String!
    var timer = Timer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        barcodeView.layer.borderWidth = 1.0
        barcodeView.layer.borderColor = UIColor.white.cgColor
        self.addSubview(barcodeView)
        
        //设置扫描线
        scanLine.frame = CGRect(x: 0, y: 0, width: barcodeView.width, height: 5)
        scanLine.image = UIImage(named: "QRCodeScanLine")
        
        //添加扫描层
        barcodeView.addSubview(scanLine)
        self.createBackGroundView()
        self.addObserver(self, forKeyPath: "scaning", options: .new, context: nil)
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(moveScannerLayer(_:)), userInfo: nil, repeats: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func  createBackGroundView() {
        let topView = UIView(frame: CGRect(x: 0,
                                           y: 0,
                                           width: UIScreen.wj_screenWidth(),
                                           height: UIScreen.wj_screenHeight() * 0.35))
        let bottomView = UIView(frame: CGRect(x: 0,
                                              y: UIScreen.wj_screenWidth() * 0.6 + UIScreen.wj_screenHeight() * 0.35,
                                              width: UIScreen.wj_screenWidth(),
                                              height: UIScreen.wj_screenHeight() * 0.65 - UIScreen.wj_screenWidth() * 0.6))
        let leftView = UIView(frame: CGRect(x: 0,
                                            y: UIScreen.wj_screenHeight() * 0.35,
                                            width: UIScreen.wj_screenWidth() * 0.2,
                                            height: UIScreen.wj_screenWidth() * 0.6))
        let rightView = UIView(frame: CGRect(x: UIScreen.wj_screenWidth() * 0.8,
                                             y: UIScreen.wj_screenHeight() * 0.35,
                                             width: UIScreen.wj_screenWidth() * 0.2,
                                             height: UIScreen.wj_screenWidth() * 0.6))
        
        topView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        bottomView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        leftView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        rightView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        
        let label = UILabel(frame: CGRect(x: 0, y: 10, width: UIScreen.wj_screenWidth(), height: 21))
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.white
        label.text = "将二维码/条形码放入扫描框内，即自动扫描"
        
        bottomView.addSubview(label)
        
        self.addSubview(topView)
        self.addSubview(bottomView)
        self.addSubview(leftView)
        self.addSubview(rightView)

    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if scanning == "start" {
            timer.fire()
        } else {
            timer.invalidate()
        }
    }
    
    /// 让扫描线滚动
    func moveScannerLayer(_ timer : Timer) {
        scanLine.frame = CGRect(x: 0, y: 0, width: self.barcodeView.width, height: 12)
        UIView.animate(withDuration: 2) { 
            self.scanLine.frame = CGRect(x: self.scanLine.frame.origin.x,
                                         y: self.scanLine.frame.origin.y + self.barcodeView.frame.size.height - 10,
                                         width: self.scanLine.frame.size.width,
                                         height: self.scanLine.frame.size.height);
        }
    }
    
}
