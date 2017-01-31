//
//  FileInfo.swift
//  VM
//
//  Created by Xinyuan Wang on 1/30/17.
//  Copyright © 2017 RJT. All rights reserved.
//

import Foundation

class FileInfo: NSObject{
    var link : String
    var downloadPath : String?
    init(linkUrl: String){
        link = linkUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)!
        super.init()
    }
}
