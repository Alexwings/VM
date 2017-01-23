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
    private static let retKey = "msg"
    static var currentUser : [String : String]?
    struct Response {
        var success : Bool = false
        var data : String?
        var errorMessage : String?
    }
    
    //MARK: user login
    class func loginViaHttp(params: [String : String], completion: @escaping (Response)->Void){
        guard let url = constructParams(url: Constants.rjtMusicApi.BaseUrl + "/" + Constants.rjtMusicApi.LoginService, params: params) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        sendGet(request: request, completion: completion)
    }
    
    class func signupViaHttp(params: [String : String], completion: @escaping (Response)->Void) {
        guard let url = constructParams(url: Constants.rjtMusicApi.BaseUrl + "/" + Constants.rjtMusicApi.RegisterService, params: params) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        sendGet(request: request, completion: completion)
    }
    
    class func resetPasswordViaHttp(params:[String : String], completion: @escaping (Response)->Void){
        guard let url = constructParams(url: Constants.rjtMusicApi.BaseUrl + "/" + Constants.rjtMusicApi.ResetPasswordService, params: params) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        sendGet(request: request, completion: completion)
    }
    
    //MARK: Private class methods
    private class func sendGet(request: URLRequest, completion: @escaping (Response)-> Void){
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                let res = Response(success: false, data: nil, errorMessage: error?.localizedDescription)
                DispatchQueue.main.async {
                    completion(res)
                }
                return
            }
            guard let r = response as? HTTPURLResponse else {
                let res = Response(success: false, data: nil, errorMessage: "Not a valid http request")
                DispatchQueue.main.async {
                    completion(res)
                }
                return
            }
            guard r.statusCode == 200 else {
                var res = Response(success: false, data: nil, errorMessage: nil)
                res.errorMessage = "Internet Faliure, Error Code: \(r.statusCode)"
                DispatchQueue.main.async {
                    completion(res)
                }
                return
            }
            guard let responseData = data else {
                let res = Response(success: false, data: nil, errorMessage: "No respond data")
                DispatchQueue.main.async {
                    completion(res)
                }
                return
            }
            do {
                let jsonObj = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments)
                guard let dict = jsonObj as? [String : Array<AnyObject>] else {
                    DispatchQueue.main.async {
                        completion(Response(success: false, data: nil, errorMessage: "Retrurn data incorrect format"))
                    }
                    return
                }
                let status = dict[retKey]?.first
                if let result = (status?.contains("success")), result {
                    DispatchQueue.main.async {
                        completion(Response(success: true, data: dict[retKey]?.last as? String, errorMessage: nil))
                    }
                }else{
                    DispatchQueue.main.async {
                        completion(Response(success: false, data: nil, errorMessage: dict[retKey]?.last as? String))
                    }
                }
                
            }catch _ {
                if let resStr = String(data: responseData, encoding: .utf8) {
                    if resStr.contains("success") {
                        DispatchQueue.main.async {
                            completion(Response(success: true, data: resStr, errorMessage: nil))
                        }
                    }else {
                        DispatchQueue.main.async {
                            completion(Response(success: false, data: nil, errorMessage: resStr))
                        }
                    }
                }else {
                    DispatchQueue.main.async {
                        completion(Response(success: false, data: nil, errorMessage: "No valid response from server"))
                    }
                }
                return
            }
        }
        task.resume()
    }
    
    private class func constructParams(url: String, params: [String : String]) -> URL? {
        var str = url + "?"
        for (key, value) in params {
            let pair = "\(key)=\(value)&"
            str.append(pair)
        }
        str.remove(at: str.index(before:str.endIndex))
        guard let finalStr = str.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed) else{
            return nil
        }
        return URL(string: finalStr)
    }
}
