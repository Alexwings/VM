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
    }
    struct UserParams {
        static let nameKey = "user_name"
        static let emailKey = "user_email"
        static let mobileKey = "user_mobile"
        static let passwordKey = "user_pass"
        static let newPasswordKey = "newpassword"
    }
}
