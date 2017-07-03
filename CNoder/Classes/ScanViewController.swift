//
//  ScanViewController.swift
//  CNoder
//
//  Created by Fussa on 2017/6/14.
//  Copyright © 2017年 fussa. All rights reserved.
//

import UIKit
import AVFoundation

class ScanViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //相机显示视图
    let cameraView = ScannerBackgroundView(frame: UIScreen.main.bounds)
    
    let captureSession = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.checkAuthorizationStatus()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.scannerStart()
    }
}

fileprivate extension ScanViewController {
    func setupUI () {
        self.navigationController?.navigationBar.isHidden = false
        self.title = "扫一扫"
        self.view.backgroundColor = UIColor.black
        self.view.addSubview(cameraView)
    }
    // 设置导航栏
    func setupNavigationaBar() {
        //        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(selectPhotoFormPhotoLibrary(_:)))
        //        self.navigationItem.rightBarButtonItem = barButtonItem
        
        //        let backBtn = UIButton.init(frame: CGRect(x: view.bounds.width - 100, y: 50, width: 60, height: 30))
        //        backBtn.titleLabel?.text = "返回"
        //        backBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
        //        view.addSubview(backBtn)
    }

    func checkAuthorizationStatus() {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let status = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
            switch status {
            case .notDetermined:
                // 许可对话没有出现，发起授权许可
                AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (granted) in
                    if (granted) {
                        //第一次用户接受
                        self.setupDevice()
                    } else {
                        // 用户拒绝
                        self.showSingerAlert("您已拒绝打开相机")
                    }
                })
            case .authorized:
                self.setupDevice()
            case .denied:
                self.showSingerAlert("您已拒绝打开相机")
            case .restricted:
                self.showSingerAlert("暂时无法打开相机")
            }
        } else {
            self.showSingerAlert("您的设备不支持相机",  completionHandler: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
        }
        
        
    }
    
    func setupDevice() {
        //初始化捕捉设备（AVCaptureDevice），类型AVMdeiaTypeVideo
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        let input: AVCaptureDeviceInput
        
        //创建媒体数据输出流
        let output = AVCaptureMetadataOutput()
        
        do {
            //创建输入流
            input = try AVCaptureDeviceInput(device: captureDevice)
            //把输入流添加到会话
            captureSession.addInput(input)
            //把输出流添加到会话
            captureSession.addOutput(output)
        } catch {
            printLog("异常")
        }
        
        //创建串行队列
        let dispatchQueue = DispatchQueue(label: "queue", attributes: [])
        //设置输出流的代理
        output.setMetadataObjectsDelegate(self, queue: dispatchQueue)
        //设置输出媒体的数据类型
        output.metadataObjectTypes = NSArray(array: [AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code]) as [AnyObject]
        
        //创建预览图层
        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        
        //设置预览图层的填充方式
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        //设置预览图层的frame
        videoPreviewLayer?.frame = cameraView.bounds
        
        //将预览图层添加到预览视图上
        cameraView.layer.insertSublayer(videoPreviewLayer!, at: 0)
        
        //设置扫描范围
        output.rectOfInterest = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
    }
    @objc fileprivate func back() {
        dismiss(animated: true, completion: nil)
    }
    /// 从相册中选择图片
//    @objc fileprivate func selectPhotoFormPhotoLibrary(_ sender : AnyObject){
//        let picture = UIImagePickerController()
//        picture.sourceType = UIImagePickerControllerSourceType.photoLibrary
//        picture.delegate = self
//        self.present(picture, animated: true, completion: nil)
//    }
    
    func scannerStart(){
        captureSession.startRunning()
        cameraView.scanning = "start"
    }
    
    func scannerStop() {
        captureSession.stopRunning()
        cameraView.scanning = "stop"
    }
}


// MARK: - AVCaptureMetadataOutputObjectsDelegate
extension ScanViewController {
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        if metadataObjects != nil && metadataObjects.count > 0 {
            let metaData: AVMetadataMachineReadableCodeObject = metadataObjects.first as! AVMetadataMachineReadableCodeObject
            if(metaData.stringValue != nil) {
                self.navigationController?.popViewController({
                    UserTool().Login(metaData.stringValue!)
                })
            }
        }
    }
}

// MARK: -  UIImagePickerControllerDelegate
//extension ScanViewController {
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        let image = info[UIImagePickerControllerOriginalImage]
//        let imageData = UIImagePNGRepresentation(image as! UIImage)
//        let ciImage = CIImage(data: imageData!)
//        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyLow])
//        let array = detector?.features(in: ciImage!)
//        let result: CIQRCodeFeature = array?.first as! CIQRCodeFeature
//        let resultView = WebViewController()
//        resultView.url = result.messageString
//        
//        self.navigationController?.pushViewController(resultView, animated: true)
//        picker.dismiss(animated: true, completion: nil)
//        printLog(result.messageString ?? String())
//        
//    }
//}
