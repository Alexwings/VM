//
//  File.swift
//  VM
//
//  Created by Xinyuan Wang on 1/22/17.
//  Copyright © 2017 RJT. All rights reserved.
//

import Foundation

struct Constants {
    struct rjtMusicApi {
        static let BaseUrl = "http://rjtmobile.com/ansari//rjt_music/music_app/"
        static let LoginService = "login.php"
        static let RegisterService = "registration.php"
        static let ResetPasswordService = "reset_pass.php"
        static let MusicAlbumService = "music_album_category.php"
        static let MusicDetailService = "music_play.php"
        static let VideoListService = "video_list.php"
    }
    struct UserParams {
        static let nameKey = "user_name"
        static let emailKey = "user_email"
        static let mobileKey = "user_mobile"
        static let passwordKey = "user_pass"
        static let newPasswordKey = "newpassword"
    }
    struct Message{
        static let statusKey = "msg"
    }
    struct MusicParams {
        static let typeTitles = ["New Releases", "RJT Top Played", "Top Compilation"]
        static let typeValues = ["new", "top-played", "top-comp"]
        static let musicListKey = "Albums"
        static let musicIdKey = "AlbumId"
        static let musicNameKey = "AlbumName"
        static let musicdescKey = "AlbumDesc"
        static let musicThumbKey = "AlbumThumb"
        static let musiclinkKey = "MusicFile"
    }
    struct VideoParams {
        static let videoNameKey = "VideoName"
        static let videoIdKey = "Id"
        static let videoDescKey = "VideoDesc"
        static let videoThumbKey = "VideoThumb"
        static let videoFileKey = "VideoFile"
        static let videoListKey = "Videos"
    }
}
