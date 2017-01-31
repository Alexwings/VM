//
//  Video.swift
//  VM
//
//  Created by Xinyuan Wang on 1/30/17.
//  Copyright © 2017 RJT. All rights reserved.
//

import Foundation

class Video: NSObject {
    let id: String
    let name: String
    let thumb: String
    let desc: String
    var file: FileInfo?
    
    init(_ params: [String : String]) {
        id = params[Constants.VideoParams.videoIdKey] ?? "NoID"
        name = params[Constants.VideoParams.videoNameKey] ?? "NoName"
        thumb = params[Constants.VideoParams.videoThumbKey] ?? "NoImage"
        desc = params[Constants.VideoParams.videoDescKey] ?? "NoDesc"
        if let f = params[Constants.VideoParams.videoFileKey] {
            file = FileInfo(linkUrl: f)
        }
        super.init()
    }
}
