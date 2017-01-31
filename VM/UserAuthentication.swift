//
//  UserAuthentication.swift
//  VM
//
//  Created by Xinyuan Wang on 1/22/17.
//  Copyright © 2017 RJT. All rights reserved.
//

import UIKit
import Foundation

class UserAuthentication{
   
    static var currentUser : [String : String]?
   
    
    //MARK: user login
    class func loginViaHttp(params: [String : String], completion: @escaping (WebProvider.Response)->Void){
        let provider = WebProvider.sharedInstance
        guard let url = provider.constructParams(url: Constants.rjtMusicApi.BaseUrl + "/" + Constants.rjtMusicApi.LoginService, params: params) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        provider.sendGet(request: request) { (response) in
            guard response.success else {
                completion(response)
                return 
            }
            let dict = response.data as! [String : Array<Any>]
            if let status = dict[Constants.Message.statusKey]?.first as? String{
                if status.contains("success"){
                    completion(response)
                    return
                }else {
                    let msg = dict[Constants.Message.statusKey]?.last
                    completion(WebProvider.Response(success: false, data: nil, errorMessage: msg as? String))
                }
            }
        }
    }
    
    class func signupViaHttp(params: [String : String], completion: @escaping (WebProvider.Response)->Void) {
        let provider = WebProvider.sharedInstance
        guard let url = provider.constructParams(url: Constants.rjtMusicApi.BaseUrl + "/" + Constants.rjtMusicApi.RegisterService, params: params) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        provider.sendGet(request: request, completion: completion)
    }
    
    class func resetPasswordViaHttp(params:[String : String], completion: @escaping (WebProvider.Response)->Void){
        let provider = WebProvider.sharedInstance
        guard let url = provider.constructParams(url: Constants.rjtMusicApi.BaseUrl + "/" + Constants.rjtMusicApi.ResetPasswordService, params: params) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        provider.sendGet(request: request, completion: completion)
    }
    
    
}
