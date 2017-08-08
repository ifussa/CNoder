//
//  HttpTool.swift
//  Patient
//
//  Created by Fussa on 2017/6/2.
//  Copyright © 2017年 gxwj. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

//MARK: - 网络请求封装: 一级封装
class HttpTool: NSObject {
    var error: NSError?

    
    /// get请求
    ///
    /// - Parameters:
    ///   - url: URL地址
    ///   - params: 提交参数
    ///   - success: 请求成功回调
    ///   - failture: 请求失败回调
    static func getRequset(url: String,
                           params : [String : AnyObject]? = nil,
                           success : @escaping (_ responseObject : [String : AnyObject])->(),
                           failture :((_ error : NSError)->())?) {
        printLog("url: \(appendBaseUrl(url))")
        Alamofire.request(appendBaseUrl(url),
                          method: .get,
                          parameters: params,
                          encoding: URLEncoding.queryString,
                          headers: nil).responseJSON{ (response) in
//                            printLog("response:\(response)")
            doWithResponse(response, success, failture)
        }
    }
    static func getRequset(url: String,
                           params : [String : AnyObject]? = nil,
                           success : @escaping (_ responseObject : [String : AnyObject])->()) {
        getRequset(url: url, params: params, success: success, failture: nil)
    }
    
    /// post请求
    ///
    /// - Parameters:
    ///   - url: URL地址
    ///   - params: 请求参数
    ///   - success: 请求成功回调
    ///   - failture: 请求失败回调
    static func postRequest(url: String,
                            params: [String: AnyObject],
                            success : @escaping (_ responseObject : [String : AnyObject])->(),
                            failture : ((_ error : NSError)->())?) {
        let headers: HTTPHeaders = ["Accept": "application/json"]
        printLog("url: \(appendBaseUrl(url))")
        request(appendBaseUrl(url),
               method: .post,
               parameters: params,
               encoding: JSONEncoding.default,
               headers: headers).validate().responseJSON { (response) in
            doWithResponse(response, success, failture)
        }
    }
    static func postRequest(url: String,
                            params: [String: AnyObject],
                            success : @escaping (_ responseObject : [String : AnyObject])->()) {
        postRequest(url: url, params: params, success: success, failture: nil)
    }
    
    /// 统一处理response信息
    private static func doWithResponse(_ response: Alamofire.DataResponse<Any>,
                                       _ success : @escaping (_ responseObject : [String : AnyObject])->(),
                                       _ failture : ((_ error : NSError)->())?) {
        switch response.result {
        case .success:
            if let value = response.value {
                success(value as! [String : AnyObject])
            }
        
        case .failure(let error):
            if failture != nil {
                printLog("error---->\(error)")
                failture!(error as NSError)
            }
        }
    }

    /// 拼接字符串
    private static func appendBaseUrl(_ url: String) -> String {
        return MAIN_URL + url
    }
}

