//
//  MusicChannel.swift
//  VM
//
//  Created by Xinyuan Wang on 1/25/17.
//  Copyright © 2017 RJT. All rights reserved.
//

import UIKit
import AVFoundation

class AlbumDetail: NSObject{
    
    static var currentMusic: AlbumDetail?
    var id : String
    var name : String
    var desc : String
    var thumb : String?
    var file : FileInfo?
    
    init(params: [String : Any]){
        id = params[Constants.MusicParams.musicIdKey] as! String
        name = params[Constants.MusicParams.musicNameKey] as! String
        desc = params[Constants.MusicParams.musicdescKey] as! String
        thumb = params[Constants.MusicParams.musicThumbKey] as? String
        if let str = params[Constants.MusicParams.musiclinkKey] as? String {
            file = FileInfo(linkUrl: str)
        }
        super.init()
    }
    
    class func getCurrentMusic(id: String, completion: @escaping () -> Void){
        let detailUrlStr = Constants.rjtMusicApi.BaseUrl + "/" + Constants.rjtMusicApi.MusicDetailService
        let param = ["id" : id]
        let detailUrl = WebProvider.sharedInstance.constructParams(url: detailUrlStr, params: param)
        let request = URLRequest(url: detailUrl!)
        WebProvider.sharedInstance.sendGet(request: request) { (response) in
            guard response.success else {
                print("Web Service Error: " + response.errorMessage!)
                return
            }
            let data = response.data as! [String : [Any]]
            guard let list = data[Constants.MusicParams.musicListKey], !list.isEmpty else {
                print("Music not found")
                return
            }
            let params = list.last as! [String : String]
            let music = AlbumDetail(params: params)
            AlbumDetail.currentMusic = music
            completion()
        }
    }
}


